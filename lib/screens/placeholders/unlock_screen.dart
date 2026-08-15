import 'package:flutter/material.dart';
import 'package:readysethire/widgets/custom_app_header.dart' show CustomAppHeader;


// --- Main Screen Widget ---
class WhoItIsForPage extends StatelessWidget {
  const WhoItIsForPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The Scaffold provides the basic app structure.
      // We use a Container with a gradient for the background to match the design.
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDF0F5), Color(0xFFF3E5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // Use a SingleChildScrollView to allow the whole page to be scrollable,
        // including the header and the main content.
        child: SingleChildScrollView(
          child: Column(
            children: [
              // The CustomAppHeader is integrated here.
              const CustomAppHeader(),
              // This is the new section built based on your image.
              const WhoItIsForSection(),
            ],
          ),
        ),
      ),
    );
  }
}

// --- The "Who It Is For" Section Widget ---
class WhoItIsForSection extends StatelessWidget {
  const WhoItIsForSection({super.key});

  @override
  Widget build(BuildContext context) {
    // The top padding is removed since the header already has its own padding.
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 30.0, 24.0, 30.0),
      child: Column(
        children: [
          // "Who It Is For" Chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE0EE),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE8A0BF), width: 1),
            ),
            child: const Text(
              'Who It Is For',
              style: TextStyle(
                color: Color(0xFF491D7F),
                fontWeight: FontWeight.w400,
                fontFamily: 'B612 Mono',
                fontSize: 8,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Main Title
          const Text(
            'Unlock Your\nProfessional Potential',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF491D7F),
              fontWeight: FontWeight.w700,
              fontFamily: 'B612 Mono',
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),

          // Description Text
          const Text(
            'Transform your career with AI-powered interview assistants built for every stage of your IT journey.Whether you\'re just starting out or aiming higher, ReadySetHire helps you stand out, sharpen your skills, and step into interviews with confidence.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8,
              color: Color(0xFF1B003C),
              fontFamily: 'B612 Mono',
              height: 1.25,
            ),
          ),
          const SizedBox(height: 40),

          // Cards Section
          // Using Wrap to let cards flow responsively.
          Wrap(
            spacing: 20, // Horizontal space between cards
            runSpacing: 35, // Vertical space between cards
            alignment: WrapAlignment.center,
            children: const [
              InfoCard(
                icon: Icons.school_outlined,
                title: 'Fresh Graduates & Job Seekers',
                description:
                'Boost your job readiness with AI-powered interview training designed to build confidence, sharpen soft skills, and reduce anxiety. Get fair, personalized feedback to help you grow and succeed—whether facing real or AI-driven interviews.',
              ),
              InfoCard(
                icon: Icons.account_balance_outlined,
                title: 'Educational Institutions',
                description:
                'Empower your students with scalable, targeted AI interview practice that boosts employability and eases faculty workload. Deliver personalized, industry-focused training and prepare students to excel in today’s AI-driven hiring landscape.',
              ),
              InfoCard(
                icon: Icons.record_voice_over_outlined,
                title: 'Career Counselors',
                description:
                'Empower your clients with AI-driven interview practice, personalized career guidance, and progress tracking. Boost engagement with gamified training designed to sharpen skills and prepare for success.',
              ),
              InfoCard(
                icon: Icons.business_center_outlined,
                title: 'Recruitment Agencies and Employers',
                description:
                'Boost your job readiness with AI-powered interview training designed to build confidence, sharpen soft skills, and reduce anxiety. Get fair, personalized feedback to help you grow and succeed—whether facing real or AI-driven interviews.',
              ),
              InfoCard(
                icon: Icons.groups_outlined,
                title: 'Community & Workforce Developers',
                description:
                'Boost your job readiness with AI-powered interview training designed to build confidence, sharpen soft skills, and reduce anxiety. Get fair, personalized feedback to help you grow and succeed—whether facing real or AI-driven interviews.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- Reusable Info Card Widget ---
class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth > 500)
            ? (constraints.maxWidth / 3 - 24)
            : (constraints.maxWidth / 2 - 12);

        return SizedBox(
          width: cardWidth,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              // Card content is pushed down to make space for the icon
              Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.fromLTRB(12, 28, 12, 12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE0EE),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFE8A0BF),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Title
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 8,
                        color: Color(0xFF491D7F),
                        fontFamily: 'B612 Mono',
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Description
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 7,
                        color: Color(0xFF491D7F),
                        fontFamily: 'B612 Mono',
                        height: 1.15,
                      ),
                    ),
                  ],
                ),
              ),
              // Icon positioned on top of the card
              Positioned(
                top: 0,
                child: Container(
                  width: 32,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8A0BF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: const Color(0xFF491D7F), size: 18),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// --- To run this screen, you can use a main function like this ---
/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WhoItIsForPage(),
    );
  }
}
*/
