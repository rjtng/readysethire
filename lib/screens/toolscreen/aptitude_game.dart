import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart' show AppTheme;
import '../../widgets/gradient_background.dart' show GradientBackground;
import '../../widgets/logo_widget.dart' show LogoWidget;
import '../../widgets/solid_button.dart' show SolidButton;
import 'aptitude_game/situational_judgement.dart' show SituationalJudgementTestScreen;

// --- SHARED THEME AND WIDGETS ---

class PacmanIcon extends StatelessWidget {
  final double size;
  const PacmanIcon({super.key, this.size = 100.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _PacmanPainter(),
      ),
    );
  }
}

class _PacmanPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()..color = AppTheme.fontColor;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0.6,
      2 * math.pi - 1.2,
      true,
      paint,
    );

    final dotRadius = radius * 0.15;
    final dotCenter = Offset(center.dx + radius * 0.5, center.dy);
    canvas.drawCircle(dotCenter, dotRadius, paint);

    final plusPaint = Paint()
      ..color = AppTheme.primaryColor
      ..strokeWidth = 2.0;
    final plusSize = radius * 0.2;
    final plusCenter = Offset(center.dx - radius * 0.3, center.dy);
    canvas.drawLine(Offset(plusCenter.dx - plusSize, plusCenter.dy),
        Offset(plusCenter.dx + plusSize, plusCenter.dy), plusPaint);
    canvas.drawLine(Offset(plusCenter.dx, plusCenter.dy - plusSize),
        Offset(plusCenter.dx, plusCenter.dy + plusSize), plusPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
                    colors: [Color(0xFF959FE2), Color(0xFF491D7F), Color(0xFFE8A0BF)],
                    stops: [0.226, 0.4615, 0.8269],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds),
                  child: Text(
                    'ReadySetHire',
                    style: GoogleFonts.b612Mono(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'Build Your Future with Confidence',
                  style: GoogleFonts.b612Mono(
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
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

// --- Aptitude Game Intro Screen ---
class AptitudeGameIntroScreen extends StatelessWidget {
  const AptitudeGameIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- STYLE FOR BOLD MONO TEXT ---
    final boldMonoStyle = GoogleFonts.b612Mono(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF3D3B3E), // Dark purple/gray from image
    );

    return GradientBackground(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const GameAppHeader(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppTheme.fontColor, size: 30),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const PacmanIcon(size: 120),
                  const SizedBox(height: 20),
                  Text('Aptitude Game',
                      style: Theme.of(context).textTheme.displayLarge),
                  const SizedBox(height: 16),

                  // --- UPDATED TEXT WIDGET ---
                  Text.rich(
                    TextSpan(
                      // Default style for all text in this widget
                      style: GoogleFonts.b612Mono(
                        fontSize: 13,
                        color: const Color(0xFF3D3B3E), // Dark purple/gray from image
                        height: 1.5, // Adds a bit of space between lines
                      ),
                      children: [
                        const TextSpan(
                          text: 'Test your soft skills and see how ready you are for real-world challenges! These tests present a series of realistic situations and ask candidates to choose responses that best reflect how they would act. Take this short aptitude test to discover your strengths in teamwork, communication, leadership, and more.\n\n',
                        ),
                        // This part creates the "Note:" line with bolding
                        const TextSpan(text: 'Note: This test is for '),
                        TextSpan(text: 'general', style: boldMonoStyle),
                        const TextSpan(text: ' '),
                        TextSpan(text: 'job-readiness', style: boldMonoStyle),
                        const TextSpan(text: ' '),
                        TextSpan(text: 'soft', style: boldMonoStyle),
                        const TextSpan(text: ' '),
                        TextSpan(text: 'skills', style: boldMonoStyle),
                        const TextSpan(text: ' assessment.'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),


                  const SizedBox(height: 80),
                  SolidButton(
                    text: 'Start',
                    onPressed: () {
                      // Directly open Situational Judgement instructions since diagrammatic
                      // and verbal tests have been removed from the flow.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AptitudeInstructionsScreen(
                            title: 'Situational Judgement Test',
                            questionCount: 10,
                            perQuestionSeconds: 30,
                            destinationScreen: const SituationalJudgementTestScreen(),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- Aptitude Game Category Screen (Unchanged) ---
class AptitudeGameCategoryScreen extends StatelessWidget {
  const AptitudeGameCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const GameAppHeader(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppTheme.fontColor, size: 30),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const PacmanIcon(size: 80),
                  const SizedBox(height: 16),
                  Text('Aptitude Game',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 32),
                  Text('Select Aptitude Test Type',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  // Only Situational Judgement remains in the flow
                  _buildCategoryButton(
                    context,
                    'Situational Judgement Test',
                        () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AptitudeTestDetailScreen(
                          title: 'Situational Judgement Test',
                          description:
                          'See beyond the scenario — show how you lead, decide, and adapt. In today\'s job market, employers don\'t just look at what you know — they care about how you think, respond, and act in real-world situations. This test gives you a chance to demonstrate your judgment, emotional intelligence, and workplace readiness. Each question presents a glimpse into challenges you may face in a professional setting. Your task? To respond with clarity, empathy, and sound decision-making. There are no trick questions — just moments that ask, "What kind of teammate, leader, or professional will you be?" Take your time, stay thoughtful, and remember: this is about progress, not perfection. Let\'s begin.',
                          destinationScreen: const SituationalJudgementTestScreen(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(
      BuildContext context, String title, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.fontColor,
          side: const BorderSide(color: AppTheme.primaryColor, width: 2),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
        ),
        child: Text(title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ),
    );
  }
}

// --- Aptitude Test Detail Screen (Unchanged) ---
class AptitudeTestDetailScreen extends StatelessWidget {
  final String title;
  final String description;
  final Widget destinationScreen;

  const AptitudeTestDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.destinationScreen,
  });

  void _startTest(BuildContext context) {
    int questionCount;
    int perQuestionSeconds = 30; // default per-question time
    if (title == 'Diagrammatic Reasoning Test') {
      questionCount = 5;
      perQuestionSeconds = 60; // diagrammatic often needs more time
    } else if (title == 'Situational Judgement Test') {
      // 3 questions per category × 5 categories = 15
      questionCount = 10;
      perQuestionSeconds = 30; // per your design
    } else {
      questionCount = 10;
      perQuestionSeconds = 30;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AptitudeInstructionsScreen(
          title: title,
          questionCount: questionCount,
          perQuestionSeconds: perQuestionSeconds,
          destinationScreen: destinationScreen,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const GameAppHeader(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppTheme.fontColor, size: 30),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge),
                  const SizedBox(height: 16),
                  Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 80),
                  SolidButton(
                    text: 'Start',
                    onPressed: () => _startTest(context),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// --- NEW Aptitude Test Instructions Screen (Unchanged) ---
class AptitudeInstructionsScreen extends StatelessWidget {
  final String title;
  final int questionCount;
  final int perQuestionSeconds;
  final Widget destinationScreen;

  const AptitudeInstructionsScreen({
    super.key,
    required this.title,
    required this.questionCount,
    required this.perQuestionSeconds,
    required this.destinationScreen,
  });

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                const GameAppHeader(),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFFCE3D7C)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFB5D5),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color.fromRGBO(206, 61, 124, 0.54), width: 2),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0,10),
                            blurRadius: 4
                        )
                      ]
                  ),
                  child: const PacmanIcon(size: 80),
                ),
                const SizedBox(height: 30),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.b612Mono(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: const Color(0xFF491D7F),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD4E7),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF747474)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        // Display like "15 questions | 30 seconds each"
                        '$questionCount questions | ${perQuestionSeconds} seconds each',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.b612Mono(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          color: const Color(0xFF3F3F3F),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Instructions:\nFind a quiet and comfortable place to take the test where you are unlikely to be interrupted. Ensure your testing environment is free from distractions to maintain focus throughout the session.\n\Make sure your computer and internet connection are working properly. Use a reliable and updated browser to access the test.\n\nOnce the timed test has begun, it cannot be paused. Please be prepared to complete the session without any breaks.\n\nCarefully read each question and all the possible answers before making your choice. There is no penalty for incorrect answers.\n\nPace yourself to make sure you have enough time to attempt all questions.",
                        style: GoogleFonts.b612Mono(
                          fontWeight: FontWeight.w700,
                          fontSize: 9,
                          color: const Color(0xFF3F3F3F),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => destinationScreen),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE8A0BF),
                    foregroundColor: const Color(0xFF491D7F),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
                    elevation: 4,
                  ),
                  child: Text(
                    'Start!',
                    style: GoogleFonts.b612Mono(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}