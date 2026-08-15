import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math; // Added for the circular painter
import 'package:readysethire/models/aptitude_test_data.dart';
import 'package:readysethire/models/test_result_model.dart' show TestResult;
import 'package:readysethire/screens/toolscreen/aptitude_game/aptitude_results_screen.dart';
import 'package:readysethire/screens/toolscreen/history_services.dart' show HistoryService;
import '../../../theme/app_theme.dart' show AppTheme;
import '../../../widgets/gradient_background.dart' show GradientBackground;
import '../aptitude_game.dart'; // Added for GameAppHeader
import 'package:provider/provider.dart';
import 'package:readysethire/models/resume_data.dart';

// --- Timer Widget (Copied from DiagrammaticReasoningTestScreen) ---
class CircularTimer extends StatelessWidget {
  final int seconds;
  const CircularTimer({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 62,
      height: 62,
      child: CustomPaint(
        painter: _CircularTimerPainter(
            progress: seconds / 30.0, color: AppTheme.fontColor),
        child: Center(
          child: Text(
            '$seconds\nsec',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.fontColor),
          ),
        ),
      ),
    );
  }
}

class _CircularTimerPainter extends CustomPainter {
  final double progress;
  final Color color;
  _CircularTimerPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, paint..color = color.withAlpha((0.2 * 255).round()));
    final progressAngle = 2 * math.pi * progress;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2, progressAngle, false, paint..color = color);
  }

  @override
  bool shouldRepaint(covariant _CircularTimerPainter oldDelegate) =>
      oldDelegate.progress != progress;
}


class SituationalJudgementTestScreen extends StatefulWidget {
  const SituationalJudgementTestScreen({super.key});

  @override
  State<SituationalJudgementTestScreen> createState() =>
      _SituationalJudgementTestScreenState();
}

class _SituationalJudgementTestScreenState
    extends State<SituationalJudgementTestScreen> {
  late List<Question> questions;
  int _currentIndex = 0;
  int _accumulatedPoints = 0;
  int _maxPointsPossible = 0;
  // Track per-category accumulated points and per-category max points
  final Map<String, int> _categoryPoints = {};
  final Map<String, int> _categoryMaxPoints = {};
  Timer? _timer;
  int _secondsRemaining = 30;
  bool _isAnswered = false;

  @override
  void initState() {
    super.initState();
    _prepareQuestions();
    _startTimer();
  }

  /// Prepare the question set: pick up to 3 random questions from each of the
  /// five categories (Communication, Teamwork, Problem-Solving, Adaptability,
  /// Emotional Intelligence). If there aren't enough questions to fill 15
  /// slots, fill the remainder from the pool of remaining situational
  /// questions.
  void _prepareQuestions() {
    // Build a pool of categorized questions and take 10 random questions.
    final rnd = math.Random();
    final all = List.of(AptitudeTestData.situationalJudgementQuestionsCategorized);

    // Shuffle the pool then take up to 10 questions (or fewer if dataset small)
    all.shuffle(rnd);
    final takeCount = math.min(10, all.length);
    final selected = all.take(takeCount).toList();

    // Shuffle options and their corresponding optionPoints for each selected question
    final shuffledSelected = selected.map((q) {
      final originalOptions = List<String>.from(q.options);
      final originalPoints = List<int>.from(q.optionPoints ?? [3, 2, 1, 0]);

      // Build index list to shuffle
      final indices = List<int>.generate(originalOptions.length, (i) => i);
      indices.shuffle(rnd);

      // Reorder options & points using the shuffled indices
      final newOptions = <String>[];
      final newPoints = <int>[];
      for (final i in indices) {
        newOptions.add(originalOptions[i]);
        newPoints.add(i < originalPoints.length ? originalPoints[i] : 0);
      }

      return Question(
        questionText: q.questionText,
        scenarioDescription: q.scenarioDescription,
        options: newOptions,
        correctOptionIndex: q.correctOptionIndex,
        explanation: q.explanation,
        category: q.category,
        optionPoints: newPoints,
      );
    }).toList()
      // final shuffle of selected questions to vary order each play
      ..shuffle(rnd);

    questions = shuffledSelected;
    if (questions.isEmpty) {
      // Fallback: use full list if selection failed (shouldn't happen)
      questions = List.of(AptitudeTestData.situationalJudgementQuestions)
        ..shuffle(rnd);
    }

    // Initialize category trackers dynamically from the selected questions
    _maxPointsPossible = 0;
    _categoryPoints.clear();
    _categoryMaxPoints.clear();

    final selectedCategories = questions.map((q) => (q.category ?? 'Uncategorized')).toSet();
    for (final cat in selectedCategories) {
      _categoryPoints[cat] = 0;
      _categoryMaxPoints[cat] = 0;
    }

    for (final q in questions) {
      final maxPoint = (q.optionPoints ?? [3, 2, 1, 0]).reduce((a, b) => a > b ? a : b);
      _maxPointsPossible += maxPoint;
      final cat = (q.category ?? 'Uncategorized');
      _categoryMaxPoints[cat] = (_categoryMaxPoints[cat] ?? 0) + maxPoint;
      _categoryPoints[cat] = (_categoryPoints[cat] ?? 0);
    }
  }

  // Helper to apply points to overall and per-category totals
  void _applyPointsToCurrentQuestion(int points) {
    _accumulatedPoints += points;
    final q = questions[_currentIndex];
    final cat = (q.category ?? 'Uncategorized');
    _categoryPoints[cat] = (_categoryPoints[cat] ?? 0) + points;
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _secondsRemaining = 30;
      _isAnswered = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
        _handleTimeUp();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _handleTimeUp() {
    if (!_isAnswered) {
      // No selection -> treat as 0 points for this question
      _showExplanationDialog(0, isTimeUp: true);
    }
  }

  void _handleOptionSelected(int index) {
    if (_isAnswered) return;

    setState(() {
      _isAnswered = true;
    });

    _timer?.cancel();
    final q = questions[_currentIndex];
    final points = (q.optionPoints != null && index >= 0 && index < q.optionPoints!.length)
        ? q.optionPoints![index]
        : [3, 2, 1, 0][index];
    _applyPointsToCurrentQuestion(points);
    _showExplanationDialog(points);
  }

  Future<void> _nextQuestion() async {
    if (_currentIndex < questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _startTimer();
    } else {
      final percentScore = _maxPointsPossible > 0
          ? (_accumulatedPoints / _maxPointsPossible) * 100
          : 0.0;
      // Build per-category percentages
      final categoryPercentages = <String, double>{};
      _categoryMaxPoints.forEach((cat, maxPts) {
        final pts = _categoryPoints[cat] ?? 0;
        final pct = maxPts > 0 ? (pts / maxPts) * 100.0 : 0.0;
        categoryPercentages[cat] = pct;
      });

      final result = TestResult(
        type: 'Aptitude Game',
        name: 'Situational Judgement Test',
        score: percentScore,
        rawScore: _accumulatedPoints,
        totalQuestions: questions.length,
        categoryPercentages: categoryPercentages,
        date: DateTime.now(),
      );
      try {
        await HistoryService.saveResult(result);
      } catch (e) {
        // Log and continue so the user can still see results even if save fails.
        // debugPrint('History save failed: $e');
      }

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AptitudeResultsScreen(
                // AptitudeResultsScreen expects an integer score (raw points).
                // Provide the accumulated raw points here. The percentScore
                // (double) has already been stored in TestResult above.
                score: _accumulatedPoints,
                categoryPercentages: categoryPercentages,
                totalQuestions: questions.length,
                testName: "Situational Judgement Test",
              ),
         ),
       );
    }
  }

  void _showExplanationDialog(int pointsEarned, {bool isTimeUp = false}) {
    final title = isTimeUp ? "Time's Up!" : 'You earned ${pointsEarned} pts';
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Text(questions[_currentIndex].explanation),
            ),
            actions: [
              TextButton(
                child: const Text('Next'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _nextQuestion();
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Question currentQuestion = questions[_currentIndex];
    final resume = Provider.of<ResumeDataProvider>(context).resumeData;
    final displayName = resume.fullName.trim().isNotEmpty
        ? resume.fullName.trim().split(RegExp(r"\s+")).first
        : null;

    return GradientBackground(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- UI UPDATE: Replaced old header with new consistent header ---
                  const GameAppHeader(),
                  const SizedBox(height: 12),
                  if (displayName != null)
                    Text('Hi $displayName, welcome to the Situational Judgement Test',
                        style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Question ${_currentIndex + 1}/${questions.length}\nSituational Judgement',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(width: 16),
                      CircularTimer(seconds: _secondsRemaining),
                    ],
                  ),
                  const Divider(height: 24),
                  // --- END UI UPDATE ---
                  Text(
                    currentQuestion.questionText,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),

                  const SizedBox(height: 16.0),

                  if (currentQuestion.scenarioDescription != null)
                    Text(
                      currentQuestion.scenarioDescription!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                          fontSize: 14,
                          color: AppTheme.fontColor),
                      textAlign: TextAlign.justify,
                    ),

                  const SizedBox(height: 24),
                  ...List.generate(currentQuestion.options.length,
                          (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: OutlinedButton(
                            onPressed: () => _handleOptionSelected(index),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.fontColor,
                              side: const BorderSide(
                                  color: AppTheme.primaryColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                              alignment: Alignment.centerLeft,
                            ),
                            child: Text(
                              currentQuestion.options[index],
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
