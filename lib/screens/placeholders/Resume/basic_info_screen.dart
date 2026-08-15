// lib/screens/basic_info_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readysethire/models/resume_data.dart';
import 'academic_background_screen.dart'; // Make sure this path is correct
import 'package:readysethire/widgets/solid_button.dart'; // Make sure this path is correct

// --- Helper classes for styles, based on your CSS ---
class AppColors {
  static const Color backgroundStart = Color(0xFFDDC4E4);
  static const Color backgroundEnd = Color(0xFFFFF0F2);
  static const Color primaryPurple = Color(0xFF491D7F);
  static const Color primaryPink = Color(0xFFE8A0BF);
  static const Color accentPink = Color(0xFFCE3D7C);
  static const Color textDark = Color(0xFF1B003C);
  static const Color textBody = Color(0xFF3F3F3F);
  static const Color textHint = Color(0xFF8C8C8C);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}

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

  static const TextStyle buttonText = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: AppColors.white,
  );
}
// --- End of helper classes ---

class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({super.key});

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _contactController;
  late final TextEditingController _emailController;
  late final TextEditingController _addressController;
  late final TextEditingController _summaryController;

  @override
  void initState() {
    super.initState();
    final resumeData =
        Provider.of<ResumeDataProvider>(context, listen: false).resumeData;

    _fullNameController = TextEditingController(text: resumeData.fullName);
    _contactController = TextEditingController(text: resumeData.contactNumber);
    _emailController = TextEditingController(text: resumeData.emailAddress);
    _addressController = TextEditingController(text: resumeData.address);
    _summaryController =
        TextEditingController(text: resumeData.professionalSummary);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    // Save data back to provider
    Provider.of<ResumeDataProvider>(context, listen: false).updateBasicInfo(
      fullName: _fullNameController.text.trim(),
      contact: _contactController.text.trim(),
      email: _emailController.text.trim(),
      address: _addressController.text.trim(),
      summary: _summaryController.text.trim(),
    );

    // Navigate to next screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AcademicBackgroundScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Allows the body to go behind the app bar
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.accentPink),
          onPressed: () {
            // Navigates back to the previous screen (AccountScreen)
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
            stops: [0.2984, 0.7419], // From CSS
          ),
        ),
        // --- Added SafeArea ---
        child: SafeArea(
          top: false, // Keep content behind app bar
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 29.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 70), // Space for app bar
                Image.network(
                  'https://i.imgur.com/jStHkjp.png',
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
                  'Basic Information',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.pageTitle,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Please fill out the following fields with your personal information. Ensure all details are accurate and up-to-date.',
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

                // --- Form Fields ---
                _buildLabeledTextField(
                  label: 'Full Name',
                  hint: 'Enter full name',
                  controller: _fullNameController,
                ),
                const SizedBox(height: 16),

                _buildLabeledTextField(
                  label: 'Contact Number',
                  hint: 'Enter contact number',
                  keyboardType: TextInputType.phone,
                  controller: _contactController,
                ),
                const SizedBox(height: 16),

                _buildLabeledTextField(
                  label: 'Email Address',
                  hint: 'Enter email address',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                const SizedBox(height: 16),

                _buildLabeledTextField(
                  label: 'Address',
                  hint: 'Enter city address',
                  keyboardType: TextInputType.streetAddress,
                  controller: _addressController,
                ),
                const SizedBox(height: 16),

                _buildLabeledTextField(
                  label: 'Professional Summary',
                  hint: 'Enter your professional summary...',
                  isMultiLine: true,
                  controller: _summaryController,
                ),
                const SizedBox(height: 40),

                SolidButton(
                  text: 'Next',
                  color: AppColors.primaryPink,
                  textColor: AppColors.black,
                  width: 273, // Pass width directly
                  height: 39, // Pass height directly
                  onPressed: _onNextPressed,
                ),

                const SizedBox(height: 50), // Extra padding at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Helper widget to build a labeled text field, matching your style.
  Widget _buildLabeledTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool isMultiLine = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            label,
            style: AppTextStyles.fieldLabel,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: isMultiLine ? 8 : 1,
          minLines: isMultiLine ? 8 : 1,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.fieldHint,
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: AppColors.black,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: AppColors.black,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: AppColors.primaryPurple, // Highlight when active
                width: 2.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}