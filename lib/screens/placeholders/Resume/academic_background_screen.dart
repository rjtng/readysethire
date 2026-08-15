import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readysethire/models/resume_data.dart';
import 'experience_screen.dart'; // Your import

// --- Helper classes for styles (reused from previous response) ---

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

  // --- FIX 3: Re-enabled the font ---
  static const TextStyle buttonText = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: AppColors.black,
  );
  // --- END FIX 3 ---

  static const TextStyle checkboxLabel = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    color: AppColors.textBody,
  );

  static const TextStyle cardTitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: AppColors.textDark,
  );
}

// --- The Academic Background Screen widget ---

class AcademicBackgroundScreen extends StatefulWidget {
  const AcademicBackgroundScreen({Key? key}) : super(key: key);

  @override
  State<AcademicBackgroundScreen> createState() =>
      _AcademicBackgroundScreenState();
}

class _AcademicBackgroundScreenState extends State<AcademicBackgroundScreen> {
  // Controllers for form fields
  late final TextEditingController _schoolController;
  late final TextEditingController _degreeController;
  late final TextEditingController _yearStartController;
  late final TextEditingController _yearEndController;

  // Helper: detect whether an AcademicEntry is 'empty' (no user-provided data)
  bool _isAcademicEntryEmpty(AcademicEntry e) {
    final isEmptyText = (String? s) => s == null || s.trim().isEmpty;
    return isEmptyText(e.schoolName) &&
        isEmptyText(e.degree) &&
        isEmptyText(e.yearStarted) &&
        isEmptyText(e.yearEnded) &&
        (e.isPresent == false);
  }

  @override
  void initState() {
    super.initState();
    _schoolController = TextEditingController();
    _degreeController = TextEditingController();
    _yearStartController = TextEditingController();
    _yearEndController = TextEditingController();

    // Load existing data from provider (if any) to prefill the form so it persists
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final resume = Provider.of<ResumeDataProvider>(context, listen: false).resumeData;
      if (resume.academicEntries.isNotEmpty) {
        final first = resume.academicEntries.first;
        setState(() {
          _schoolController.text = first.schoolName ?? '';
          _degreeController.text = first.degree ?? '';
          _yearStartController.text = first.yearStarted ?? '';
          _yearEndController.text = first.yearEnded ?? '';
          // Note: AcademicEntry currently doesn't store educational stage; leave it as user selection.
        });
      }
    });
  }

  @override
  void dispose() {
    _schoolController.dispose();
    _degreeController.dispose();
    _yearStartController.dispose();
    _yearEndController.dispose();
    super.dispose();
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
        child: SafeArea( // Keep SafeArea
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 29.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                // Logo from Network URL
                Image.network(
                  'https://i.imgur.com/jStHkjp.png', // Your logo URL
                  width: 193,
                  height: 179,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 193,
                      height: 179,
                      color: AppColors.primaryPurple.withAlpha(26),
                      child: const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: AppColors.primaryPurple,
                          size: 50,
                        ),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 193,
                      height: 179,
                      color: AppColors.primaryPurple.withAlpha(26),
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null,
                          color: AppColors.primaryPurple,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 29),
                const Text(
                  'Academic Background',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.pageTitle,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Please provide a complete record of your academic qualifications. List all credentials in chronological order.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.pageSubtitle,
                ),
                const SizedBox(height: 12),
                Container(
                  width: 354,
                  height: 5,
                  color: AppColors.primaryPink,
                ),
                const SizedBox(height: 32),

                // --- Dynamic list of academic entries ---
                Consumer<ResumeDataProvider>(builder: (context, provider, _) {
                  final entries = provider.resumeData.academicEntries;
                  return Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: entries.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 20),
                        itemBuilder: (context, idx) => _AcademicEntryCard(index: idx),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Builder(builder: (context) {
                            final canAdd = provider.resumeData.academicEntries.isEmpty ||
                                !_isAcademicEntryEmpty(provider.resumeData.academicEntries.last);
                            return ElevatedButton.icon(
                              onPressed: canAdd
                                  ? () {
                                      provider.addAcademicEntry(AcademicEntry());
                                    }
                                  : null,
                              icon: const Icon(Icons.add),
                              label: const Text('Add Academic Entry'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: canAdd ? AppColors.primaryPink : Colors.grey.shade400,
                                foregroundColor: AppColors.black,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Next navigation button
                      SizedBox(
                        width: 273,
                        height: 39,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ExperienceScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryPink,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            elevation: 0,
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text('Next', style: AppTextStyles.buttonText),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  );
                }),

                // --- END: rest of page ---
               ],
             ),
           ),
         ),
       ),
     );
   }
 }

/// Individual editable academic card.
class _AcademicEntryCard extends StatefulWidget {
  final int index;
  const _AcademicEntryCard({Key? key, required this.index}) : super(key: key);

  @override
  State<_AcademicEntryCard> createState() => _AcademicEntryCardState();
}

class _AcademicEntryCardState extends State<_AcademicEntryCard> {
  late TextEditingController _schoolController;
  late TextEditingController _degreeController;
  late TextEditingController _yearStartController;
  late TextEditingController _yearEndController;
  String? _selectedStage;
  bool _isPresent = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ResumeDataProvider>(context, listen: false);
    final entry = provider.resumeData.academicEntries[widget.index];
    _schoolController = TextEditingController(text: entry.schoolName ?? '');
    _degreeController = TextEditingController(text: entry.degree ?? '');
    _yearStartController = TextEditingController(text: entry.yearStarted ?? '');
    _yearEndController = TextEditingController(text: entry.yearEnded ?? '');
    _isPresent = entry.isPresent;
    _selectedStage = null;
  }

  @override
  void dispose() {
    _schoolController.dispose();
    _degreeController.dispose();
    _yearStartController.dispose();
    _yearEndController.dispose();
    super.dispose();
  }

  void _save() {
    final provider = Provider.of<ResumeDataProvider>(context, listen: false);
    final updated = AcademicEntry(
      schoolName: _schoolController.text.trim(),
      degree: _degreeController.text.trim(),
      yearStarted: _yearStartController.text.trim(),
      yearEnded: _isPresent ? '' : _yearEndController.text.trim(),
      isPresent: _isPresent,
    );
    provider.updateAcademicEntry(widget.index, updated);
    setState(() => _isEditing = false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Academic entry saved')));
  }

  void _delete() {
    final provider = Provider.of<ResumeDataProvider>(context, listen: false);
    provider.removeAcademicEntry(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.cardBackground.withAlpha(153), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text('Academic Entry', style: AppTextStyles.cardTitle)),
              IconButton(icon: const Icon(Icons.edit), onPressed: () => setState(() => _isEditing = true)),
              IconButton(icon: const Icon(Icons.delete), onPressed: _delete),
            ],
          ),
          const SizedBox(height: 8),
          _academicLabeledDropdown(label: 'Educational Stage', hint: 'Choose educational stage', value: _selectedStage, items: kEducationalStages, onChanged: _isEditing ? (v) => setState(() => _selectedStage = v) : null),
          const SizedBox(height: 12),
          _academicLabeledTextField(label: 'School Name', hint: 'Enter school name', controller: _schoolController, enabled: _isEditing),
          const SizedBox(height: 12),
          _academicLabeledTextField(label: 'Degree / Program', hint: 'Enter degree / program', controller: _degreeController, enabled: _isEditing),
          const SizedBox(height: 12),
          Row(children: [Expanded(child: _academicLabeledTextField(label: 'Year Start', hint: 'YYYY', controller: _yearStartController, enabled: _isEditing)), const SizedBox(width: 12), Expanded(child: _academicLabeledTextField(label: 'Year Ended', hint: 'YYYY', controller: _yearEndController, enabled: _isEditing))]),
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [Checkbox(value: _isPresent, onChanged: _isEditing ? (v) => setState(() => _isPresent = v ?? false) : null), const SizedBox(width: 8), const Text('Present', style: TextStyle(fontWeight: FontWeight.bold))]),
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [if (_isEditing) ElevatedButton(onPressed: _save, child: const Text('Save'))])
        ],
      ),
    );
  }
}

// --- Top-level helpers and card widget for Academic entries ---

const List<String> kEducationalStages = [
  'High School',
  'Associate Degree',
  'Bachelor\'s Degree',
  'Master\'s Degree',
  'Doctoral Degree',
  'Vocational/Technical',
  'Other',
];

Widget _academicLabeledTextField({
  required String label,
  required String hint,
  TextEditingController? controller,
  bool enabled = true,
  bool isMultiLine = false,
  TextInputType keyboardType = TextInputType.text,
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
        maxLines: isMultiLine ? 6 : 1,
        keyboardType: keyboardType,
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

Widget _academicLabeledDropdown({
  required String label,
  required String hint,
  required String? value,
  required List<String> items,
  required ValueChanged<String?>? onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(padding: const EdgeInsets.only(left: 12.0), child: Text(label, style: AppTextStyles.fieldLabel)),
      const SizedBox(height: 8),
      Container(
        height: 41,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(10.0), border: Border.all(color: AppColors.black, width: 1.0)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            hint: Text(hint, style: AppTextStyles.fieldHint),
            icon: const Icon(Icons.arrow_drop_down, color: AppColors.black),
            isExpanded: true,
            style: AppTextStyles.fieldHint.copyWith(color: AppColors.textBody),
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<String>>((String item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          ),
        ),
      ),
    ],
  );
}
