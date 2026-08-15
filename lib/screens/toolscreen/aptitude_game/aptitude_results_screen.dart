import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readysethire/theme/app_theme.dart';
import 'package:readysethire/widgets/gradient_background.dart';
import 'package:readysethire/widgets/logo_widget.dart';
import 'package:readysethire/widgets/solid_button.dart';
import 'dart:math' as math; // Import for pi

// Assume your custom widgets (GradientBackground, LogoWidget, SolidButton)
// and AppTheme (AppTheme.primaryColor) are defined elsewhere.

class AptitudeResultsScreen extends StatelessWidget {
  // --- Fields ---
  final int score;
  final int totalQuestions;
  final String testName;
  final Map<String, double>? categoryPercentages;
  final Map<String, String>? categoryFeedback;

  const AptitudeResultsScreen({
    super.key,
    // --- Parameters ---
    required this.score,
    required this.totalQuestions,
    required this.testName,
    this.categoryPercentages,
    this.categoryFeedback,
  });

  @override
  Widget build(BuildContext context) {
    // If category percentages were not provided, build a fallback map
    final categories = categoryPercentages != null && categoryPercentages!.isNotEmpty
        ? categoryPercentages!
        : {
      'Communication': 89.0,
      'Teamwork': 89.0,
      'Problem-Solving': 89.0,
      'Adaptability': 89.0,
      'Emotional Intelligence': 89.0,
    };

    // Define the icons for the feedback list
    final Map<String, IconData> categoryIcons = {
      'Communication': Icons.person,
      'Teamwork': Icons.group,
      'Problem-Solving': Icons.help_outline,
      'Adaptability': Icons.sync,
      'Emotional Intelligence': Icons.lightbulb_outline,
    };

    // --- START: DYNAMIC FEEDBACK LOGIC ---

    // 1. Define POSITIVE feedback (if user passed)
    final Map<String, String> positiveFeedbacks = {
      'Communication': 'You demonstrated clear and thoughtful communication in most scenarios. Your responses show an ability to convey ideas logically and respectfully.',
      'Teamwork': "Your choices reflected strong collaboration and respect for others' perspectives. You often prioritized group goals over personal preferences.",
      'Problem-Solving': 'You approached complex situations with practical reasoning and creativity. Your answers indicated a preference for structured analysis.',
      'Adaptability': 'You showed flexibility in responding to changing priorities and unexpected developments. You remain composed and solution-oriented.',
      'Emotional Intelligence': 'Your responses demonstrated empathy and self-awareness. You were able to recognize emotional cues and respond with professionalism.'
    };

    // 2. Define "NEEDS IMPROVEMENT" feedback (if user failed)
    final Map<String, String> needsImprovementFeedbacks = {
      'Communication': 'Your responses sometimes lacked clarity. Try to be more precise and ensure you fully understand the question before answering.',
      'Teamwork': 'Your choices often prioritized individual goals over the team. Remember to consider your colleagues\' perspectives and the group\'s shared objectives.',
      'Problem-Solving': 'You struggled with complex situations. Focus on breaking down problems into smaller parts and analyzing them more methodically.',
      'Adaptability': 'You seemed to prefer rigid processes. Practice being more flexible when priorities change unexpectedly, as this is a key skill.',
      'Emotional Intelligence': 'Your responses showed a lack of empathy or self-awareness. Try to be more mindful of emotional cues in workplace settings.'
    };

    // 3. Calculate the overall percentage
    // We add a check for totalQuestions > 0 to avoid dividing by zero
    final double overallPercent = (totalQuestions > 0) ? (score / totalQuestions) * 100 : 0;

    // 4. Set a "pass" mark (e.g., 60%)
    final bool didPass = overallPercent >= 60;

    // 5. Choose the correct feedback map based on the score
    // This replaces the old static 'feedbacks' map.
    // If 'categoryFeedback' is provided (not null), it will be used.
    // Otherwise, it checks if the user passed and picks the correct map.
    final Map<String, String> feedbacks = categoryFeedback ?? (didPass
        ? positiveFeedbacks
        : needsImprovementFeedbacks);

    // --- END: DYNAMIC FEEDBACK LOGIC ---


    // Helper function to build a single chart widget
    Widget buildChart(MapEntry<String, double> entry) {
      final pct = (entry.value).clamp(0.0, 100.0);
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DonutChart(
            percent: pct / 100.0,
            label: entry.key,
          ),
          const SizedBox(height: 6),
          Text(
            entry.key,
            // Added fallback TextStyle for safety
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 10) ??
                const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      );
    }

    final categoryEntries = categories.entries.toList();

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent, // Important for GradientBackground
        body: SafeArea(
          // Use SingleChildScrollView to prevent overflow
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // --- Custom Header ---
                  Row(
                    children: [
                      const LogoWidget(size: 50),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ReadySetHire',
                            style: GoogleFonts.b612Mono(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          Text(
                            'Aptitude Feedback Summary',
                            style: GoogleFonts.b612Mono(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: const Color(0xFF656565),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- Donut Charts Layout (2-2-1) ---
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (categoryEntries.isNotEmpty)
                            buildChart(categoryEntries[0]), // Communication
                          if (categoryEntries.length > 1)
                            buildChart(categoryEntries[1]), // Teamwork
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (categoryEntries.length > 2)
                            buildChart(categoryEntries[2]), // Problem-Solving
                          if (categoryEntries.length > 3)
                            buildChart(categoryEntries[3]), // Adaptability
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (categoryEntries.length > 4)
                            buildChart(categoryEntries[4]), // Emotional Intelligence
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // --- Feedback Card ---
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCE7F3), // Light pink color
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: categories.keys.map((cat) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                categoryIcons[cat] ?? Icons.circle,
                                size: 24,
                                // Replaced AppTheme.fontColor with a specific color
                                color: Colors.black.withOpacity(0.7),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$cat:',
                                      // Added fallback TextStyle for safety
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.bold) ??
                                          const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      // This text now comes from the correct feedback map
                                      feedbacks[cat] ?? '',
                                      // Added fallback TextStyle for safety
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5) ??
                                          const TextStyle(fontSize: 13, height: 1.5, color: Colors.black87),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // --- Done Button ---
                  SolidButton(
                    text: 'Done',
                    onPressed: () {
                      // Example: Pop back two screens
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- DonutChart widget (Unchanged) ---
class DonutChart extends StatelessWidget {
  final double percent; // 0.0 - 1.0
  final String label;
  final double size;
  const DonutChart({super.key, required this.percent, required this.label, this.size = 110});

  @override
  Widget build(BuildContext context) {
    final display = (percent * 100).round();
    final double strokeWidth = size * 0.20;
    final double innerCircleDiameter = size - (2 * strokeWidth);

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _DonutPainter(
          progress: percent,
          color: AppTheme.primaryColor, // This should be defined in your AppTheme
          strokeWidth: strokeWidth,
        ),
        child: Center(
          child: Container(
            width: innerCircleDiameter,
            height: innerCircleDiameter,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
            ),
            child: Center(
              child: Text(
                '$display%',
                // Added fallback TextStyle for safety
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16, fontWeight: FontWeight.w700) ??
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- _DonutPainter class (Unchanged) ---
class _DonutPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _DonutPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = strokeWidth;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - stroke) / 2;

    // Background semi-transparent ring
    final bgPaint = Paint()
      ..color = color.withAlpha((0.18 * 255).round()) // 18% opacity
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;

    // Foreground progress ring
    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round; // Rounded ends

    canvas.drawCircle(center, radius, bgPaint);

    final angle = 2 * math.pi * progress;
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2, // Start from the top
        angle,
        false,
        fgPaint
    );
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) =>
      oldDelegate.progress != progress ||
          oldDelegate.color != color ||
          oldDelegate.strokeWidth != strokeWidth;
}