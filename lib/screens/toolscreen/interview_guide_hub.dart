import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:readysethire/screens/toolscreen/interview%20guide/how_to_dress.dart' show HowToDressScreen;
import 'package:readysethire/screens/toolscreen/interview%20guide/job_interview_tips.dart' show JobInterviewTipsScreen;
import 'package:readysethire/screens/toolscreen/interview%20guide/resume_optimizer.dart' show ResumeOptimizerScreen;

import '../../widgets/logo_widget.dart' show LogoWidget;


// --- UI Screen ---

class InterviewGuideHubScreen extends StatelessWidget {
  const InterviewGuideHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF2E6FF), // Light purple
              Color(0xFFFFF9FB), // Light pinkish white
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding:
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GameAppHeader(),
                const SizedBox(height: 24),
                IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: Color(0xFFC46BAD), size: 36),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                ),
                const SizedBox(height: 24),
                const Center(
                  child: Text(
                    'From resume hacks to interview strategies, find the support you need to move forward',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xFF491D7F),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                InfoCard(
                  icon: Icons.work_outline,
                  title: 'Job Interview Tips',
                  subtitle:
                  'Master your next job interview with tips that turn opportunities into offers',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const JobInterviewTipsScreen()),
                    );
                  },
                ),
                InfoCard(
                  icon: Icons.person_search_outlined,
                  title: 'Resume Optimizer & Tips Section',
                  subtitle:
                  'Stand out with a resume that speaks for your skills and experience',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResumeOptimizerScreen()),
                    );
                  },
                ),
                InfoCard(
                  icon: Icons.checkroom_outlined,
                  title: 'How To Dress for a Job Interview',
                  subtitle:
                  'Dress smart, feel confident—how to choose the right interview attire.',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HowToDressScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Custom Widgets for this screen ---

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const monoStyle =
    TextStyle(fontFamily: 'monospace', color: Color(0xFF491D7F));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 12.0),
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF9FB).withOpacity(0.9),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFE8A0BF),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 50, color: const Color(0xFF491D7F)),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style:
              monoStyle.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: monoStyle.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class GameAppHeader extends StatelessWidget {
  const GameAppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const LogoWidget(size: 50),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xFF959FE2),
                      Color(0xFF491D7F),
                      Color(0xFFE8A0BF)
                    ],
                    stops: [0.226, 0.4615, 0.8269],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds),
                  child: Text(
                    'ReadySetHire',
                    style: GoogleFonts.b612Mono(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'Build Your Future with Confidence',
                  style: GoogleFonts.b612Mono(
                    fontWeight: FontWeight.w700,
                    fontSize: 8,
                    color: const Color(0xFF656565),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 5,
          color: const Color(0xFFE8A0BF),
        ),
      ],
    );
  }
}



