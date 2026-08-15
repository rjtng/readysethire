import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readysethire/models/resume_data.dart';

import 'export_resume_screen.dart';

/*
================================================================================
NOTE: Ensure the 'B612 Mono' font is in your pubspec.yaml
and you have the INTERNET permission in your AndroidManifest.xml
================================================================================
*/

// --- Helper classes for styles ---

/// Contains all the colors from the CSS file.
class AppColors {
  static const Color backgroundStart = Color(0xFFDDC4E4);
  static const Color backgroundEnd = Color(0xFFFFF0F2);
  static const Color primaryPurple = Color(0xFF491D7F);
  static const Color primaryPink = Color(0xFFE8A0BF);
  static const Color accentPink = Color(0xFFCE3D7C);
  static const Color cardBackground = Color(0xFFFFD4E7);
  static const Color textDark = Color(0xFF1B003C);
  static const Color textBody = Color(0xFF3F3F3F);
  static const Color textHint = Color(0xFF8C8C8C);
  static const Color skillText = Color(0xFF656565);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}

/// Contains all the text styles from the CSS file.
class AppTextStyles {
  static const String fontFamily = 'B612 Mono';

  static const TextStyle pageTitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 25,
    color: AppColors.primaryPurple,
  );

  static const TextStyle pageSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 9,
    color: AppColors.textDark,
  );

  static const TextStyle cardTitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: AppColors.primaryPurple,
  );

  static const TextStyle fieldLabel = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: AppColors.textBody,
  );

  static const TextStyle fieldHint = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 13,
    color: AppColors.textHint,
  );

  static const TextStyle checkboxLabel = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    color: AppColors.textBody,
  );

  static const TextStyle skillLabel = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 7, // From CSS
    color: AppColors.skillText,
  );

  // --- FIX 1: Re-enabled the custom font ---
  static const TextStyle buttonText = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: AppColors.primaryPurple,
  );
// --- END FIX 1 ---
}

// --- The main screen widget ---

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({Key? key}) : super(key: key);

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  // State for all the skills
  // We'll load saved skill values from the provider on init and keep
  // a local copy for fast UI updates. Keys use 'Communication' instead
  // of the old 'Collaboration' label.
  // Initialize with canonical keys to avoid null lookups on first build
  final Map<String, bool> _skills = {
    'Communication': false,
    'Teamwork': false,
    'Conflict Resolution': false,
    'Critical Thinking': false,
    'Decision-Making': false,
    'Problem-Solving': false,
    'Integrity': false,
    'Professionalism': false,
    'Goal-Oriented': false,
    'Initiative': false,
    'Accountability': false,
    'Adaptability': false,
    'Flexibility': false,
    'Self-Confidence': false,
    'Emotional Intelligence': false,
    'Positive Attitude': false,
    'Organization': false,
    'Time Management': false,
  };

  @override
  void initState() {
    super.initState();
    // Defer provider access until after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ResumeDataProvider>(context, listen: false);
      final saved = Map<String, bool>.from(provider.resumeData.skills);

      // Migrate old key 'Collaboration' -> 'Communication' if present
      if (saved.containsKey('Collaboration') && !saved.containsKey('Communication')) {
        saved['Communication'] = saved['Collaboration']!;
        saved.remove('Collaboration');
      }

      // Define the canonical skill keys we want to show
      const canonical = [
        'Communication',
        'Teamwork',
        'Conflict Resolution',
        'Critical Thinking',
        'Decision-Making',
        'Problem-Solving',
        'Integrity',
        'Professionalism',
        'Goal-Oriented',
        'Initiative',
        'Accountability',
        'Adaptability',
        'Flexibility',
        'Self-Confidence',
        'Emotional Intelligence',
        'Positive Attitude',
        'Organization',
        'Time Management',
      ];

      // Populate local _skills with saved values or default false
      for (final k in canonical) {
        _skills[k] = saved[k] ?? false;
      }

      // If provider doesn't have these keys, persist the defaults so prefs reflect them
      provider.setSkills(_skills);
      setState(() {});
    });
  }

  // Helper: check if an ExperienceEntry contains any user data
  bool _isExperienceEntryEmpty(ExperienceEntry e) {
    final empty = (String? s) => s == null || s.trim().isEmpty;
    return empty(e.jobTitle) && empty(e.company) && empty(e.startYear) && empty(e.endYear) && empty(e.description) && e.isPresent == false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.accentPink),
          onPressed: () {
            // Navigates back to the previous screen
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.backgroundStart,
              AppColors.backgroundEnd,
            ],
            stops: [0.2984, 0.7419],
          ),
        ),
        // Added SafeArea to prevent button from being cut off
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 29.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                // Logo
                Image.network(
                  'https://i.imgur.com/jStHkjp.png', // Logo URL
                  width: 193,
                  height: 179,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 193,
                    height: 179,
                    color: AppColors.primaryPurple.withAlpha(26),
                    child:
                    const Icon(Icons.error, color: AppColors.primaryPurple),
                  ),
                ),
                const SizedBox(height: 29),

                // Title
                const Text(
                  'Experience',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.pageTitle,
                ),
                const SizedBox(height: 12),

                // Subtitle
                const Text(
                  'Please detail your work experience, internships, or relevant extracurricular activities below. If you do not have formal experience in this area, this section is optional to complete.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.pageSubtitle,
                ),
                const SizedBox(height: 12),

                // Divider
                Container(
                  width: 354,
                  height: 5,
                  color: AppColors.primaryPink,
                ),
                const SizedBox(height: 30),

                // --- Dynamic list of experience entries from provider, grouped by category ---
                Consumer<ResumeDataProvider>(builder: (context, provider, _) {
                  final allEntries = provider.resumeData.experienceEntries;

                  Widget section(String category, String title) {
                    final categoryWithIndices = <MapEntry<int, ExperienceEntry>>[];
                    for (var i = 0; i < allEntries.length; i++) {
                      if (allEntries[i].category == category) {
                        categoryWithIndices.add(MapEntry(i, allEntries[i]));
                      }
                    }

                    final bool canAdd = categoryWithIndices.isEmpty ||
                        !_isExperienceEntryEmpty(categoryWithIndices.last.value);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppTextStyles.cardTitle),
                        const SizedBox(height: 12),
                        if (categoryWithIndices.isEmpty)
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground.withAlpha(153),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text('No entries yet. Tap Add to create one.'),
                          )
                        else
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: categoryWithIndices.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 12),
                            itemBuilder: (context, idx) {
                              final globalIndex = categoryWithIndices[idx].key;
                              return _ExperienceEntryCard(index: globalIndex);
                            },
                          ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: canAdd
                                  ? () {
                                      provider.addExperienceEntry(
                                        ExperienceEntry(category: category),
                                      );
                                    }
                                  : null,
                              icon: const Icon(Icons.add),
                              label: const Text('Add'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: canAdd ? AppColors.primaryPink : Colors.grey.shade400,
                                foregroundColor: AppColors.black,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      section('Work', 'Work Experience'),
                      const SizedBox(height: 20),
                      section('Internship', 'Internship / On-the-Job Training (OJT)'),
                      const SizedBox(height: 20),
                      section('Extracurricular', 'Extracurricular Activities'),
                      const SizedBox(height: 20),
                    ],
                  );
                }),

                // --- Skills Card ---
                _buildSkillsCard(),
                const SizedBox(height: 60),

                // --- Next Button ---
                SizedBox(
                  width: 273,
                  height: 39,
                  child: ElevatedButton(
                    onPressed: () {
                      // Save skills into the provider
                      final provider = Provider.of<ResumeDataProvider>(context, listen: false);
                      provider.setSkills(_skills);

                      // Navigate to Export screen
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ExportResumeScreen(),
                        ),
                      );
                    },
                    // --- FIX 2: Added padding: EdgeInsets.zero ---
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryPink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 0,
                      padding: EdgeInsets.zero, // This fixes the button text
                    ),
                    // --- END FIX 2 ---
                    child: const Text(
                      'Next',
                      style: AppTextStyles.buttonText,
                    ),
                  ),
                ),
                const SizedBox(height: 50), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the "Add Skill" card with a grid of checkboxes.
  Widget _buildSkillsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(64),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Skill:',
            style: AppTextStyles.cardTitle,
          ),
          const SizedBox(height: 20),
          // Creating the 3-column grid
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SkillCheckbox(
                      label: 'Communication',
                      value: _skills['Communication']!,
                      onChanged: (val) {
                        final newVal = val ?? false;
                        setState(() => _skills['Communication'] = newVal);
                        // persist immediately
                        Provider.of<ResumeDataProvider>(context, listen: false).setSkill('Communication', newVal);
                      },
                    ),
                    _SkillCheckbox(
                      label: 'Critical Thinking',
                      value: _skills['Critical Thinking']!,
                      onChanged: (val) {
                        final newVal = val ?? false;
                        setState(() => _skills['Critical Thinking'] = newVal);
                        Provider.of<ResumeDataProvider>(context, listen: false).setSkill('Critical Thinking', newVal);
                      },
                    ),
                    _SkillCheckbox(
                      label: 'Integrity',
                      value: _skills['Integrity']!,
                      onChanged: (val) {
                        final newVal = val ?? false;
                        setState(() => _skills['Integrity'] = newVal);
                        Provider.of<ResumeDataProvider>(context, listen: false).setSkill('Integrity', newVal);
                      },
                    ),
                    _SkillCheckbox(
                      label: 'Initiative',
                      value: _skills['Initiative']!,
                      onChanged: (val) {
                        final newVal = val ?? false;
                        setState(() => _skills['Initiative'] = newVal);
                        Provider.of<ResumeDataProvider>(context, listen: false).setSkill('Initiative', newVal);
                      },
                    ),
                    _SkillCheckbox(
                      label: 'Flexibility',
                      value: _skills['Flexibility']!,
                      onChanged: (val) {
                        final newVal = val ?? false;
                        setState(() => _skills['Flexibility'] = newVal);
                        Provider.of<ResumeDataProvider>(context, listen: false).setSkill('Flexibility', newVal);
                      },
                    ),
                    _SkillCheckbox(
                      label: 'Positive Attitude',
                      value: _skills['Positive Attitude']!,
                      onChanged: (val) {
                        final newVal = val ?? false;
                        setState(() => _skills['Positive Attitude'] = newVal);
                        Provider.of<ResumeDataProvider>(context, listen: false).setSkill('Positive Attitude', newVal);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SkillCheckbox(
                      label: 'Teamwork',
                      value: _skills['Teamwork']!,
                      onChanged: (val) {
                        final newVal = val ?? false;
                        setState(() => _skills['Teamwork'] = newVal);
                        Provider.of<ResumeDataProvider>(context, listen: false).setSkill('Teamwork', newVal);
                      },
                    ),
                    _SkillCheckbox(
                      label: 'Decision-Making',
                      value: _skills['Decision-Making']!,
                      onChanged: (val) {
                        final newVal = val ?? false;
                        setState(() => _skills['Decision-Making'] = newVal);
                        Provider.of<ResumeDataProvider>(context, listen: false).setSkill('Decision-Making', newVal);
                      },
                    ),
                    _SkillCheckbox(
                      label: 'Professionalism',
                      value: _skills['Professionalism']!,
                      onChanged: (val) {
                        final newVal = val ?? false;
                        setState(() => _skills['Professionalism'] = newVal);
                        Provider.of<ResumeDataProvider>(context, listen: false).setSkill('Professionalism', newVal);
                      },
                    ),
                    _SkillCheckbox(
                      label: 'Accountability',
                      value: _skills['Accountability']!,
                      onChanged: (val) {
                        final newVal = val ?? false;
                        setState(() => _skills['Accountability'] = newVal);
                        Provider.of<ResumeDataProvider>(context, listen: false).setSkill('Accountability', newVal);
                      },
                    ),
                    _SkillCheckbox(
                      label: 'Self-Confidence',
                      value: _skills['Self-Confidence']!,
                      onChanged: (val) {
                        final newVal = val ?? false;
                        setState(() => _skills['Self-Confidence'] = newVal);
                        Provider.of<ResumeDataProvider>(context, listen: false).setSkill('Self-Confidence', newVal);
                      },
                    ),
                    _SkillCheckbox(
                      label: 'Organization',
                      value: _skills['Organization']!,
                      onChanged: (val) {
                        final newVal = val ?? false;
                        setState(() => _skills['Organization'] = newVal);
                        Provider.of<ResumeDataProvider>(context, listen: false).setSkill('Organization', newVal);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SkillCheckbox(
                      label: 'Conflict Resolution',
                      value: _skills['Conflict Resolution']!,
                      onChanged: (val) {
                        final newVal = val ?? false;
                        setState(() => _skills['Conflict Resolution'] = newVal);
                        Provider.of<ResumeDataProvider>(context, listen: false).setSkill('Conflict Resolution', newVal);
                      },
                    ),
                    _SkillCheckbox(
                      label: 'Problem-Solving',
                      value: _skills['Problem-Solving']!,
                      onChanged: (val) {
                        final newVal = val ?? false;
                        setState(() => _skills['Problem-Solving'] = newVal);
                        Provider.of<ResumeDataProvider>(context, listen: false).setSkill('Problem-Solving', newVal);
                      },
                    ),
                    _SkillCheckbox(
                      label: 'Goal-Oriented',
                      value: _skills['Goal-Oriented']!,
                      onChanged: (val) {
                        final newVal = val ?? false;
                        setState(() => _skills['Goal-Oriented'] = newVal);
                        Provider.of<ResumeDataProvider>(context, listen: false).setSkill('Goal-Oriented', newVal);
                      },
                    ),
                    _SkillCheckbox(
                      label: 'Adaptability',
                      value: _skills['Adaptability']!,
                      onChanged: (val) {
                        final newVal = val ?? false;
                        setState(() => _skills['Adaptability'] = newVal);
                        Provider.of<ResumeDataProvider>(context, listen: false).setSkill('Adaptability', newVal);
                      },
                    ),
                    _SkillCheckbox(
                      label: 'Emotional Intelligence',
                      value: _skills['Emotional Intelligence']!,
                      onChanged: (val) {
                        final newVal = val ?? false;
                        setState(() => _skills['Emotional Intelligence'] = newVal);
                        Provider.of<ResumeDataProvider>(context, listen: false).setSkill('Emotional Intelligence', newVal);
                      },
                    ),
                    _SkillCheckbox(
                      label: 'Time Management',
                      value: _skills['Time Management']!,
                      onChanged: (val) {
                        final newVal = val ?? false;
                        setState(() => _skills['Time Management'] = newVal);
                        Provider.of<ResumeDataProvider>(context, listen: false).setSkill('Time Management', newVal);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Individual editable experience card.
class _ExperienceEntryCard extends StatefulWidget {
  final int index;
  const _ExperienceEntryCard({Key? key, required this.index}) : super(key: key);

  @override
  State<_ExperienceEntryCard> createState() => _ExperienceEntryCardState();
}

class _ExperienceEntryCardState extends State<_ExperienceEntryCard> {
  late TextEditingController _jobController;
  late TextEditingController _companyController;
  late TextEditingController _startController;
  late TextEditingController _endController;
  late TextEditingController _descController;
  bool _isPresent = false;
  bool _isEditing = false;

  bool _isEntryEmpty(ExperienceEntry e) {
    final empty = (String? s) => s == null || s.trim().isEmpty;
    return empty(e.jobTitle) && empty(e.company) && empty(e.startYear) && empty(e.endYear) && empty(e.description) && e.isPresent == false;
  }

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ResumeDataProvider>(context, listen: false);
    final e = provider.resumeData.experienceEntries[widget.index];
    _jobController = TextEditingController(text: e.jobTitle ?? '');
    _companyController = TextEditingController(text: e.company ?? '');
    _startController = TextEditingController(text: e.startYear ?? '');
    _endController = TextEditingController(text: e.endYear ?? '');
    _descController = TextEditingController(text: e.description ?? '');
    _isPresent = e.isPresent;
    // Start in editing mode if this entry looks empty (newly added)
    _isEditing = _isEntryEmpty(e);
  }

  @override
  void dispose() {
    _jobController.dispose();
    _companyController.dispose();
    _startController.dispose();
    _endController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _save() {
    final provider = Provider.of<ResumeDataProvider>(context, listen: false);
    final updated = ExperienceEntry(
      jobTitle: _jobController.text.trim(),
      company: _companyController.text.trim(),
      startYear: _startController.text.trim(),
      endYear: _isPresent ? '' : _endController.text.trim(),
      isPresent: _isPresent,
      description: _descController.text.trim(),
      category: provider.resumeData.experienceEntries[widget.index].category,
    );
    provider.updateExperienceEntry(widget.index, updated);
    setState(() => _isEditing = false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Experience entry saved')));
  }

  void _delete() {
    final provider = Provider.of<ResumeDataProvider>(context, listen: false);
    provider.removeExperienceEntry(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ResumeDataProvider>(context);
    // If the entry was removed while this widget is mounted, guard.
    if (widget.index >= provider.resumeData.experienceEntries.length) return const SizedBox.shrink();
    final entry = provider.resumeData.experienceEntries[widget.index];

    // Map category to a readable title
    String title;
    String field1Label = 'Job Title';
    String field1Hint = 'Enter job title';
    String field2Label = 'Company';
    String field2Hint = 'Enter company';

    switch (entry.category) {
      case 'Internship':
        title = 'Internship / OJT';
        field1Label = 'Company / Institution';
        field1Hint = 'Enter company / institution';
        field2Label = 'Role / Task';
        field2Hint = 'Enter position / task';
        break;
      case 'Extracurricular':
        title = 'Extracurricular Activities';
        field1Label = 'Organization / Club Name';
        field1Hint = 'Enter organization / club name';
        field2Label = 'Position / Task';
        field2Hint = 'Enter position / task';
        break;
      default:
        title = 'Work Experience';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withAlpha(153),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: AppTextStyles.cardTitle)),
              IconButton(icon: const Icon(Icons.edit), onPressed: () => setState(() => _isEditing = true)),
              IconButton(icon: const Icon(Icons.delete), onPressed: _delete),
            ],
          ),
          const SizedBox(height: 8),
          _labeledTextField(label: field1Label, hint: field1Hint, controller: _jobController, enabled: _isEditing),
          const SizedBox(height: 8),
          _labeledTextField(label: field2Label, hint: field2Hint, controller: _companyController, enabled: _isEditing),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: _labeledTextField(label: 'Start Year', hint: 'YYYY', keyboardType: TextInputType.number, controller: _startController, enabled: _isEditing)),
            const SizedBox(width: 12),
            Expanded(child: _labeledTextField(label: 'End Year', hint: 'YYYY', keyboardType: TextInputType.number, controller: _endController, enabled: _isEditing)),
          ]),
          const SizedBox(height: 8),
          _labeledTextField(label: 'Description', hint: 'Describe role', controller: _descController, isMultiLine: true, enabled: _isEditing),
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Checkbox(value: _isPresent, onChanged: _isEditing ? (v) => setState(() => _isPresent = v ?? false) : null),
            const SizedBox(width: 8),
            const Text('Present', style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [if (_isEditing) ElevatedButton(onPressed: _save, child: const Text('Save'))])
        ],
      ),
    );
  }
}

/// A small top-level helper used by the inline experience cards (keeps logic local).
Widget _labeledTextField({
  required String label,
  required String hint,
  TextEditingController? controller,
  bool isMultiLine = false,
  TextInputType keyboardType = TextInputType.text,
  bool enabled = true,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Text(label, style: AppTextStyles.fieldLabel),
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        maxLines: isMultiLine ? 6 : 1,
        minLines: isMultiLine ? 3 : 1,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.fieldHint,
          filled: true,
          fillColor: enabled ? AppColors.white : AppColors.textHint.withAlpha(26),
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: AppColors.black, width: 1.0)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: AppColors.black, width: 1.0)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: AppColors.primaryPurple, width: 2.0)),
        ),
      ),
    ],
  );
}


/// Helper widget for an individual skill checkbox.
class _SkillCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const _SkillCheckbox({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryPurple,
            checkColor: AppColors.white,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            side: const BorderSide(color: AppColors.textBody, width: 1.0),
          ),
          // Use Flexible to prevent long text from overflowing
          Flexible(
            child: Text(
              label,
              style: AppTextStyles.skillLabel,
              softWrap: true, // Allow text to wrap if needed
            ),
          ),
        ],
      ),
    );
  }
}
