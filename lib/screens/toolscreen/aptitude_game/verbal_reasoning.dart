// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:math' as math; // Added for the circular painter
// import 'package:readysethire/models/aptitude_test_data.dart';
// import 'package:readysethire/models/test_result_model.dart';
// import 'package:readysethire/screens/toolscreen/history_services.dart';
// import 'aptitude_results_screen.dart';
// import '../../../theme/app_theme.dart' show AppTheme;
// import '../../../widgets/gradient_background.dart' show GradientBackground;
// import '../aptitude_game.dart'; // Added for GameAppHeader
//
// // --- Timer Widget (Copied from DiagrammaticReasoningTestScreen) ---
// class CircularTimer extends StatelessWidget {
//   final int seconds;
//   const CircularTimer({super.key, required this.seconds});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 62,
//       height: 62,
//       child: CustomPaint(
//         painter: _CircularTimerPainter(
//             progress: seconds / 30.0, color: AppTheme.fontColor),
//         child: Center(
//           child: Text(
//             '$seconds\nsec',
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: AppTheme.fontColor),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _CircularTimerPainter extends CustomPainter {
//   final double progress;
//   final Color color;
//   _CircularTimerPainter({required this.progress, required this.color});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..strokeWidth = 4
//       ..style = PaintingStyle.stroke;
//
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2;
//
//     canvas.drawCircle(center, radius, paint..color = color.withOpacity(0.2));
//     final progressAngle = 2 * math.pi * progress;
//     canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
//         -math.pi / 2, progressAngle, false, paint..color = color);
//   }
//
//   @override
//   bool shouldRepaint(covariant _CircularTimerPainter oldDelegate) =>
//       oldDelegate.progress != progress;
// }
//
// class VerbalReasoningTestScreen extends StatefulWidget {
//   const VerbalReasoningTestScreen({super.key});
//
//   @override
//   State<VerbalReasoningTestScreen> createState() =>
//       _VerbalReasoningTestScreenState();
// }
//
// class _VerbalReasoningTestScreenState extends State<VerbalReasoningTestScreen> {
//   late List<Question> questions;
//   int _currentIndex = 0;
//   int _score = 0;
//   Timer? _timer;
//   int _secondsRemaining = 30;
//   bool _isAnswered = false;
//
//   @override
//   void initState() {
//     super.initState();
//     questions = List.of(AptitudeTestData.verbalReasoningQuestions)..shuffle();
//     _startTimer();
//   }
//
//   void _startTimer() {
//     _timer?.cancel();
//     setState(() {
//       _secondsRemaining = 30;
//       _isAnswered = false;
//     });
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (!mounted) {
//         timer.cancel();
//         return;
//       }
//       if (_secondsRemaining > 0) {
//         setState(() {
//           _secondsRemaining--;
//         });
//       } else {
//         timer.cancel();
//         _handleTimeUp();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   void _handleTimeUp() {
//     if (!_isAnswered) {
//       _showExplanationDialog(false, isTimeUp: true);
//     }
//   }
//
//   void _handleOptionSelected(int index) {
//     if (_isAnswered) return;
//
//     setState(() {
//       _isAnswered = true;
//     });
//
//     _timer?.cancel();
//     final bool isCorrect =
//         index == questions[_currentIndex].correctOptionIndex;
//     _showExplanationDialog(isCorrect);
//   }
//
//   void _nextQuestion({bool? isCorrect}) {
//     if (isCorrect == true) {
//       _score++;
//     }
//
//     if (_currentIndex < questions.length - 1) {
//       setState(() {
//         _currentIndex++;
//       });
//       _startTimer();
//     } else {
//       final result = TestResult(
//         type: 'Aptitude Game',
//         name: 'Verbal Reasoning Test',
//         score: (_score / questions.length) * 100,
//         date: DateTime.now(),
//         rawScore: _score,
//         totalQuestions: questions.length,
//       );
//       HistoryService.saveResult(result);
//
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => AptitudeResultsScreen(
//             score: _score,
//             totalQuestions: questions.length,
//             testName: "Verbal Reasoning Test",
//           ),
//         ),
//       );
//     }
//   }
//
//   void _showExplanationDialog(bool isCorrect, {bool isTimeUp = false}) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         title: Text(isTimeUp
//             ? "Time's Up!"
//             : (isCorrect ? 'Correct!' : 'Incorrect')),
//         content: SingleChildScrollView(
//           child: Text(questions[_currentIndex].explanation),
//         ),
//         actions: [
//           TextButton(
//             child: const Text('Next'),
//             onPressed: () {
//               Navigator.of(context).pop();
//               _nextQuestion(isCorrect: isCorrect && !isTimeUp);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Question currentQuestion = questions[_currentIndex];
//     return GradientBackground(
//       child: Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // --- UI UPDATE: Replaced old header with new consistent header ---
//                   const GameAppHeader(),
//                   const SizedBox(height: 24),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           'Question ${_currentIndex + 1}/${questions.length}\nVerbal Reasoning',
//                           style: Theme.of(context).textTheme.bodyLarge,
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       CircularTimer(seconds: _secondsRemaining),
//                     ],
//                   ),
//                   const Divider(height: 24),
//                   // --- END UI UPDATE ---
//                   Text(
//                     currentQuestion.questionText,
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyLarge
//                         ?.copyWith(
//                         fontWeight: FontWeight.bold, fontSize: 14),
//                   ),
//                   const SizedBox(height: 24),
//                   ...List.generate(currentQuestion.options.length,
//                           (index) {
//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 10.0),
//                           child: SizedBox(
//                             width: double.infinity,
//                             child: OutlinedButton(
//                               onPressed: () => _handleOptionSelected(index),
//                               style: OutlinedButton.styleFrom(
//                                 foregroundColor: AppTheme.fontColor,
//                                 side: const BorderSide(
//                                     color: AppTheme.primaryColor),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 12, vertical: 16),
//                               ),
//                               child: Text(
//                                 currentQuestion.options[index],
//                                 textAlign: TextAlign.center,
//                                 style: const TextStyle(fontSize: 14),
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
