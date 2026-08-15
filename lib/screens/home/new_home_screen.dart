import 'package:flutter/material.dart';
import 'package:readysethire/screens/toolscreen/mock_interview.dart' show MockInterviewIntroScreen;
import 'package:readysethire/widgets/custom_app_header.dart';

// Note: I've used hardcoded colors from your new design.
// If you have these in an AppTheme file, it's best to reference them from there.
const Color primaryTextColor = Color(0xFF491D7F);
const Color secondaryTextColor = Color(0xFF1B003C);
const Color accentColorPink = Color(0xFFE8A0BF);
const Color lightPinkBackground = Color(0xFFFFD4E7);
const Color iconBackgroundColor = Color(0xFFFF81B7);
const Color profileBorderColor = Color(0xFFE8A0BF);
const Color profileIconColor = Color(0xFFCE3D7C);

class NewHomeScreen extends StatelessWidget {
  const NewHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using a Scaffold to provide a basic app structure
    return Scaffold(
      body: Container(
        // Applying the gradient background from the new design
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.8, -1.0),
            end: Alignment(0.8, 1.0),
            colors: [Color(0xFFDDC4E4), Color(0xFFFFF0F2)],
            stops: [0.2984, 0.7419],
          ),
        ),
        child: const SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section replaced with the custom widget
                CustomAppHeader(),

                // Main content with padding
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24),
                      // "Where Preparation Meets Opportunity" Text
                      Text(
                        'Where\nPreparation\nMeets\nOpportunity.',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 28, // Adjusted for better readability
                          color: primaryTextColor,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 16),
                      // Description Text
                      Text(
                        'ReadySetHire transforms your interview preparation with personalized simulations, real-time AI coaching, and gamified aptitude tests — giving you the feedback and strategies you need to excel and land the job you deserve.',
                        style: TextStyle(
                          fontSize: 14, // Adjusted for better readability
                          fontWeight: FontWeight.w400,
                          color: secondaryTextColor,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 24),
                      // "Start Mock Interview" Button with new styling
                      _StartInterviewButton(),
                      SizedBox(height: 48),
                      // "Three Simple Steps" Section
                      Center(
                        child: Text(
                          'Three Simple Steps to\nInterview Success!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22, // Adjusted
                            color: primaryTextColor,
                            height: 1.2,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: Text(
                          'Ready to ace your next interview? Get started in minutes with our AI-powered tools—designed to help you grow, improve, and succeed.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14, // Adjusted
                            fontWeight: FontWeight.w400,
                            color: secondaryTextColor,
                            height: 1.3,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      // Step cards with new styling
                      _StepCard(
                        icon: Icons.check_circle_outline,
                        title: 'Choose Your Tools',
                        description: 'Equip yourself with the right tools to boost your interview readiness and career confidence.',
                      ),
                      SizedBox(height: 16),
                      _StepCard(
                        icon: Icons.rocket_launch_outlined,
                        title: 'Experience AI Power',
                        description: 'Harness the intelligence of AI to prepare smarter, faster, and more effectively.',
                      ),
                      SizedBox(height: 16),
                      _StepCard(
                        icon: Icons.trending_up,
                        title: 'Accelerate Growth',
                        description: 'Receive instant, actionable feedback and insights to dramatically improve your performance.',
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Private widget for the start interview button
class _StartInterviewButton extends StatelessWidget {
  const _StartInterviewButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MockInterviewIntroScreen(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColorPink,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5,
        shadowColor: accentColorPink.withOpacity(0.5),
      ),
      child: const Text(
        'Start Mock Interview',
        style: TextStyle(
          color: primaryTextColor,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }
}


// Updated step card widget to match the new design
class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: lightPinkBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: accentColorPink.withOpacity(0.6),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: primaryTextColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: primaryTextColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: primaryTextColor,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
