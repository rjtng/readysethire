import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AcademicEntry {
  String? schoolName;
  String? degree;
  String? yearStarted;
  String? yearEnded;
  bool isPresent = false;

  AcademicEntry({
    this.schoolName,
    this.degree,
    this.yearStarted,
    this.yearEnded,
    this.isPresent = false,
  });

  factory AcademicEntry.fromJson(Map<String, dynamic> json) => AcademicEntry(
        schoolName: json['schoolName'] as String?,
        degree: json['degree'] as String?,
        yearStarted: json['yearStarted'] as String?,
        yearEnded: json['yearEnded'] as String?,
        isPresent: json['isPresent'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'schoolName': schoolName,
        'degree': degree,
        'yearStarted': yearStarted,
        'yearEnded': yearEnded,
        'isPresent': isPresent,
      };
}

class ExperienceEntry {
  String? jobTitle;
  String? company;
  String? startYear;
  String? endYear;
  bool isPresent = false;
  String? description;
  String category; // New: category to group entries (e.g., 'Work', 'Internship', 'Extracurricular')

  ExperienceEntry({
    this.jobTitle,
    this.company,
    this.startYear,
    this.endYear,
    this.isPresent = false,
    this.description,
    this.category = 'Work',
  });

  factory ExperienceEntry.fromJson(Map<String, dynamic> json) => ExperienceEntry(
        jobTitle: json['jobTitle'] as String?,
        company: json['company'] as String?,
        startYear: json['startYear'] as String?,
        endYear: json['endYear'] as String?,
        isPresent: json['isPresent'] as bool? ?? false,
        description: json['description'] as String?,
        category: json['category'] as String? ?? 'Work',
      );

  Map<String, dynamic> toJson() => {
        'jobTitle': jobTitle,
        'company': company,
        'startYear': startYear,
        'endYear': endYear,
        'isPresent': isPresent,
        'description': description,
        'category': category,
      };
}

class ResumeData {
  String fullName = '';
  String contactNumber = '';
  String emailAddress = '';
  String address = '';
  String professionalSummary = '';
  // progressLevel indicates how far the user completed their resume: 'none','basic','academic','experience','completed'
  String progressLevel = 'none';

  List<AcademicEntry> academicEntries = [AcademicEntry()];
  List<ExperienceEntry> experienceEntries = [];
  Map<String, bool> skills = {};

  ResumeData({
    this.fullName = '',
    this.contactNumber = '',
    this.emailAddress = '',
    this.address = '',
    this.professionalSummary = '',
    List<AcademicEntry>? academicEntries,
    List<ExperienceEntry>? experienceEntries,
    Map<String, bool>? skills,
    String? progressLevel,
  }) {
    if (academicEntries != null) this.academicEntries = academicEntries;
    if (experienceEntries != null) this.experienceEntries = experienceEntries;
    if (skills != null) this.skills = skills;
    if (progressLevel != null) this.progressLevel = progressLevel;
  }

  factory ResumeData.fromJson(Map<String, dynamic> json) {
    return ResumeData(
      fullName: json['fullName'] as String? ?? '',
      contactNumber: json['contactNumber'] as String? ?? '',
      emailAddress: json['emailAddress'] as String? ?? '',
      address: json['address'] as String? ?? '',
      professionalSummary: json['professionalSummary'] as String? ?? '',
      academicEntries: (json['academicEntries'] as List<dynamic>?)
              ?.map((e) => AcademicEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [AcademicEntry()],
      experienceEntries: (json['experienceEntries'] as List<dynamic>?)
              ?.map((e) => ExperienceEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      skills: (json['skills'] as Map<String, dynamic>?)
              ?.map((k, v) => MapEntry(k, v as bool)) ??
          {},
      progressLevel: json['progressLevel'] as String? ?? 'none',
    );
  }

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'contactNumber': contactNumber,
        'emailAddress': emailAddress,
        'address': address,
        'professionalSummary': professionalSummary,
        'academicEntries': academicEntries.map((e) => e.toJson()).toList(),
        'experienceEntries': experienceEntries.map((e) => e.toJson()).toList(),
        'skills': skills,
        'progressLevel': progressLevel,
      };
}

class ResumeDataProvider extends ChangeNotifier {
  static const String _prefsKey = 'resume_data_json';

  final ResumeData _resumeData = ResumeData();
  StreamSubscription<User?>? _authSub;

  ResumeData get resumeData => _resumeData;

  // Public accessor for progress level
  String get progressLevel => _resumeData.progressLevel;

  // Convenience: check if user's progress meets or exceeds a minimum level
  bool meetsProgress(String minLevel) {
    const order = ['none', 'basic', 'academic', 'experience', 'completed'];
    final userIdx = order.indexOf(_resumeData.progressLevel);
    final minIdx = order.indexOf(minLevel);
    if (userIdx == -1 || minIdx == -1) return false;
    return userIdx >= minIdx;
  }

  ResumeDataProvider() {
    // fire-and-forget load; UI can listen to provider and rebuild when ready
    _loadFromPrefs();
    // Listen to auth state changes; when a user signs in, load their resume from Firestore
    try {
      _authSub = FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user != null) {
          // load user resume from Firestore and overwrite local copy
          _loadFromFirestore();
        } else {
          // signed out: clear local resume data so it doesn't leak between accounts
          _clearLocalData();
        }
      });
    } catch (e) {
      if (kDebugMode) print('Failed to subscribe to auth changes: $e');
    }
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }

  // Save the resume data to Firestore (if user signed in)
  Future<void> _saveToFirestore() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      final docRef = FirebaseFirestore.instance.collection('resumes').doc(user.uid);
      // Ensure progressLevel is included
      final payload = _resumeData.toJson();
      payload['progressLevel'] = _resumeData.progressLevel;
      await docRef.set(payload);
    } catch (e) {
      if (kDebugMode) print('Failed to save resume to Firestore: $e');
    }
  }

  // Load resume data from Firestore for the signed-in user and persist locally
  Future<void> _loadFromFirestore() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      final doc = await FirebaseFirestore.instance.collection('resumes').doc(user.uid).get();
      if (!doc.exists || doc.data() == null) {
        // If remote document doesn't exist, push local prefs (if any) to Firestore so user's local data is preserved
        await _saveToFirestore();
        return;
      }
      final Map<String, dynamic> jsonMap = doc.data()! as Map<String, dynamic>;
      final loaded = ResumeData.fromJson(jsonMap);

      // Copy loaded fields into _resumeData
      _resumeData.fullName = loaded.fullName;
      _resumeData.contactNumber = loaded.contactNumber;
      _resumeData.emailAddress = loaded.emailAddress;
      _resumeData.address = loaded.address;
      _resumeData.professionalSummary = loaded.professionalSummary;
      _resumeData.academicEntries = loaded.academicEntries;
      _resumeData.experienceEntries = loaded.experienceEntries;
      _resumeData.skills = loaded.skills;
      _resumeData.progressLevel = loaded.progressLevel;

      notifyListeners();
      // persist locally as well
      await _saveToPrefs();
    } catch (e) {
      if (kDebugMode) print('Failed to load resume from Firestore: $e');
    }
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_prefsKey);
      if (raw == null || raw.isEmpty) return;
      final Map<String, dynamic> jsonMap = json.decode(raw) as Map<String, dynamic>;
      final loaded = ResumeData.fromJson(jsonMap);

      // Copy loaded fields into _resumeData
      _resumeData.fullName = loaded.fullName;
      _resumeData.contactNumber = loaded.contactNumber;
      _resumeData.emailAddress = loaded.emailAddress;
      _resumeData.address = loaded.address;
      _resumeData.professionalSummary = loaded.professionalSummary;
      _resumeData.academicEntries = loaded.academicEntries;
      _resumeData.experienceEntries = loaded.experienceEntries;
      _resumeData.skills = loaded.skills;

      notifyListeners();
    } catch (e) {
      if (kDebugMode) print('Failed to load resume data: $e');
    }
  }

  Future<void> _saveToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = json.encode(_resumeData.toJson());
      await prefs.setString(_prefsKey, raw);
      // Compute and set progress level before saving to Firestore
      _resumeData.progressLevel = _computeProgressLevel(_resumeData);

      // After saving locally, also attempt to save to Firestore for the signed-in user.
      // Firestore save is fire-and-forget here.
      unawaited(_saveToFirestore());
    } catch (e) {
      if (kDebugMode) print('Failed to save resume data: $e');
    }
  }

  // Compute a simple progress level based on filled fields
  String _computeProgressLevel(ResumeData data) {
    // completed means has at least one experience entry with jobTitle
    final hasExperience = data.experienceEntries.isNotEmpty && data.experienceEntries.any((e) => (e.jobTitle?.trim().isNotEmpty ?? false));
    if (hasExperience) return 'experience';

    // academic: has at least one academic entry with schoolName
    final hasAcademic = data.academicEntries.isNotEmpty && data.academicEntries.any((a) => (a.schoolName?.trim().isNotEmpty ?? false));
    if (hasAcademic) return 'academic';

    // basic: full name or email present
    final hasBasic = data.fullName.trim().isNotEmpty || data.emailAddress.trim().isNotEmpty;
    if (hasBasic) return 'basic';

    return 'none';
  }

  // Clear local in-memory data and prefs
  Future<void> _clearLocalData() async {
    _resumeData.fullName = '';
    _resumeData.contactNumber = '';
    _resumeData.emailAddress = '';
    _resumeData.address = '';
    _resumeData.professionalSummary = '';
    _resumeData.academicEntries = [AcademicEntry()];
    _resumeData.experienceEntries = [];
    _resumeData.skills = {};
    notifyListeners();
    await clearPrefs();
  }

  // Helper to allow unawaited calls without importing package:async's unawaited
  void unawaited(Future<void> future) {}

  Future<void> clearPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_prefsKey);
    } catch (e) {
      if (kDebugMode) print('Failed to clear resume data: $e');
    }
  }

  void updateBasicInfo({
    required String fullName,
    required String contact,
    required String email,
    required String address,
    required String summary,
  }) {
    _resumeData.fullName = fullName;
    _resumeData.contactNumber = contact;
    _resumeData.emailAddress = email;
    _resumeData.address = address;
    _resumeData.professionalSummary = summary;

    notifyListeners();
    _saveToPrefs();
  }

  // Academic entries helpers
  void addAcademicEntry(AcademicEntry entry) {
    _resumeData.academicEntries.add(entry);
    notifyListeners();
    _saveToPrefs();
  }

  void updateAcademicEntry(int index, AcademicEntry entry) {
    if (index < 0 || index >= _resumeData.academicEntries.length) return;
    _resumeData.academicEntries[index] = entry;
    notifyListeners();
    _saveToPrefs();
  }

  void removeAcademicEntry(int index) {
    if (index < 0 || index >= _resumeData.academicEntries.length) return;
    _resumeData.academicEntries.removeAt(index);
    notifyListeners();
    _saveToPrefs();
  }

  // Experience entries helpers
  void addExperienceEntry(ExperienceEntry entry) {
    _resumeData.experienceEntries.add(entry);
    notifyListeners();
    _saveToPrefs();
  }

  void updateExperienceEntry(int index, ExperienceEntry entry) {
    if (index < 0 || index >= _resumeData.experienceEntries.length) return;
    _resumeData.experienceEntries[index] = entry;
    notifyListeners();
    _saveToPrefs();
  }

  void removeExperienceEntry(int index) {
    if (index < 0 || index >= _resumeData.experienceEntries.length) return;
    _resumeData.experienceEntries.removeAt(index);
    notifyListeners();
    _saveToPrefs();
  }

  // Skills helpers
  void setSkill(String name, bool value) {
    _resumeData.skills[name] = value;
    notifyListeners();
    _saveToPrefs();
  }

  void setSkills(Map<String, bool> skills) {
    _resumeData.skills = Map.from(skills);
    notifyListeners();
    _saveToPrefs();
  }
}
