import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// --- REMOVED: No longer needed for Firestore submission ---
// import 'package:http/http.dart' as http;
import 'dart:async';

// --- Centralized constants ---
class AppConstants {
  // No longer needed
}

// --- App's color palette ---
class AppColors {
  // ... (no changes here)
  static const Color backgroundStart = Color(0xFFDDC4E4);
  static const Color backgroundEnd = Color(0xFFFFF0F2);
  static const Color textDark = Color(0xFF491D7F);
  static const Color textMedium = Color(0xFF656565);
  static const Color textLight = Color(0xFF491D7F);
  static const Color headerIconBg = Color(0xFFE8A0BF);
  static const Color submitButton = Color(0xFFE8A0BF);
  static const Color line = Color(0xFFE8A0BF);
  static const Color selectedCardBg = Color(0xFFFFB2D3);
  static const Color unselectedCardBg = Colors.white;
  static const Color cardBorder = Color(0xFF747474);
  static const Color messageBoxBackground = Color(0xFFFFFFFF);
  static const Color messageBoxBorder = Color(0xFF000000);
  static const Color messageBoxHint = Color(0xFF8C8C8C);
  static const Color lowPriority = Color(0xFF55A31A);
  static const Color mediumPriority = Color(0xFFED8A28);
  static const Color highPriority = Color(0xFFD44242);
}

// --- Centralized Text Styles ---
class AppTextStyles {
  // ... (no changes here)
  static const String fontFamily = 'B612 Mono';
  static const TextStyle headerTitle = TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: fontFamily, color: AppColors.textDark);
  static const TextStyle headerSubtitle = TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: fontFamily, color: AppColors.textMedium);
  static const TextStyle sectionTitle = TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: fontFamily, color: AppColors.textMedium);
  static const TextStyle cardTitle = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: fontFamily, color: AppColors.textDark);
  static const TextStyle cardSubtitle = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: fontFamily, color: AppColors.textLight);
  static const TextStyle priorityLabel = TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w700, fontSize: 14);
  static const TextStyle messageHint = TextStyle(color: AppColors.messageBoxHint, fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w700);
  static const TextStyle submitButton = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: fontFamily);
}

// Enums for FeedbackType and PriorityLevel
enum FeedbackType { bug, feature, question, general }
enum PriorityLevel { low, medium, high }

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  FeedbackType _selectedFeedbackType = FeedbackType.bug;
  PriorityLevel _selectedPriority = PriorityLevel.medium;
  final TextEditingController _messageController = TextEditingController();
  bool _isSubmitting = false;

  String get messageHintText {
    // ... (no changes here)
    switch (_selectedFeedbackType) {
      case FeedbackType.bug: return 'Please describe the issue in detail, including steps to reproduce it.';
      case FeedbackType.feature: return 'Describe the feature you\'d like to see and why it would be helpful.';
      case FeedbackType.question: return 'What would you like to know?';
      case FeedbackType.general: return 'Share your thoughts or suggestions with us.';
    }
  }

  // --- MODIFIED: This function now saves feedback to Firestore ---
  Future<void> _submitFeedback() async {
    if (_messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a message before submitting.')),
      );
      return;
    }
    // --- NEW: Get the current user to link the feedback to their account ---
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to submit feedback.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // Create a reference to the 'feedback' collection
      final collection = FirebaseFirestore.instance.collection('feedback');

      // Add a new document with the feedback data
      await collection.add({
        'userId': user.uid,
        'userEmail': user.email,
        'feedbackType': _selectedFeedbackType.name, // .name gets the enum value as a string
        'priority': _selectedPriority.name,
        'message': _messageController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(), // Use the server's time for accuracy
        'status': 'new', // A default status for tracking
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Feedback submitted successfully! Thank you.')),
        );
        _messageController.clear();
        setState(() {
          _selectedFeedbackType = FeedbackType.bug;
          _selectedPriority = PriorityLevel.medium;
        });
      }
    } catch (e) {
      debugPrint('Firestore Submission Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ... (no changes to the build method or other widgets)
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildSectionTitle('Feedback Type'),
                const SizedBox(height: 16),
                _buildFeedbackTypeSelector(),
                const SizedBox(height: 32),
                _buildSectionTitle('Priority Level'),
                const SizedBox(height: 16),
                _buildPrioritySelector(),
                const SizedBox(height: 32),
                _buildSectionTitle('Message'),
                const SizedBox(height: 16),
                _buildMessageBox(),
                const SizedBox(height: 40),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(color: AppColors.headerIconBg, shape: BoxShape.circle),
              child: const Icon(Icons.chat_bubble_outline, color: AppColors.textDark, size: 32),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Share Your Feedback', style: AppTextStyles.headerTitle),
                  SizedBox(height: 4),
                  Text('Help us improve your experience', style: AppTextStyles.headerSubtitle),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          height: 5,
          decoration: BoxDecoration(color: AppColors.line, borderRadius: BorderRadius.circular(5)),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) => Text(title, style: AppTextStyles.sectionTitle);

  Widget _buildFeedbackTypeSelector() {
    final feedbackTypes = {
      FeedbackType.bug: {'icon': Icons.bug_report, 'title': 'Bug Report', 'subtitle': 'Report an issue or unexpected behavior'},
      FeedbackType.feature: {'icon': Icons.lightbulb, 'title': 'Feature Request', 'subtitle': 'Suggest a new feature or improvement'},
      FeedbackType.question: {'icon': Icons.question_mark_rounded, 'title': 'Question', 'subtitle': 'Ask a question about the website'},
      FeedbackType.general: {'icon': Icons.chat_bubble_outline, 'title': 'General Feedback', 'subtitle': 'Share your thoughts or suggestions'},
    };
    return Column(
      children: feedbackTypes.entries.map((entry) {
        return FeedbackTypeCard(
          icon: entry.value['icon'] as IconData,
          title: entry.value['title'] as String,
          subtitle: entry.value['subtitle'] as String,
          isSelected: _selectedFeedbackType == entry.key,
          onTap: () => setState(() => _selectedFeedbackType = entry.key),
        );
      }).toList(),
    );
  }

  Widget _buildPrioritySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildRadioOption(PriorityLevel.low, 'Low', AppColors.lowPriority),
        _buildRadioOption(PriorityLevel.medium, 'Medium', AppColors.mediumPriority),
        _buildRadioOption(PriorityLevel.high, 'High', AppColors.highPriority),
      ],
    );
  }

  Widget _buildRadioOption(PriorityLevel value, String label, Color color) {
    return GestureDetector(
      onTap: () => setState(() => _selectedPriority = value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<PriorityLevel>(
            value: value,
            groupValue: _selectedPriority,
            onChanged: (newValue) => setState(() => _selectedPriority = newValue ?? _selectedPriority),
            activeColor: color,
            visualDensity: VisualDensity.compact,
          ),
          Text(label, style: AppTextStyles.priorityLabel.copyWith(color: color)),
        ],
      ),
    );
  }

  Widget _buildMessageBox() {
    return TextField(
      controller: _messageController,
      maxLines: 6,
      decoration: InputDecoration(
        hintText: messageHintText,
        hintStyle: AppTextStyles.messageHint,
        filled: true,
        fillColor: AppColors.messageBoxBackground,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.messageBoxBorder, width: 1.0)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.messageBoxBorder, width: 1.0)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.submitButton, width: 2.0)),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _isSubmitting ? null : _submitFeedback,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.submitButton,
          foregroundColor: AppColors.textDark,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 2,
        ),
        child: _isSubmitting
            ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(AppColors.textDark)))
            : const Text('Share Your Insights', style: AppTextStyles.submitButton),
      ),
    );
  }
}

class FeedbackTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const FeedbackTypeCard({super.key, required this.icon, required this.title, required this.subtitle, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.selectedCardBg : AppColors.unselectedCardBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.cardBorder, width: isSelected ? 2.0 : 1.0),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textDark, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.cardTitle),
                  const SizedBox(height: 4),
                  Text(subtitle, style: AppTextStyles.cardSubtitle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
