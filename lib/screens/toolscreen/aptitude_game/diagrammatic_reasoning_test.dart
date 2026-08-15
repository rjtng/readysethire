// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'dart:math' as math;
// import 'dart:async';
// import 'package:readysethire/models/aptitude_test_data.dart';
// import 'package:readysethire/models/test_result_model.dart' show TestResult;
// import 'package:readysethire/screens/toolscreen/aptitude_game/aptitude_results_screen.dart' show AptitudeResultsScreen;
// import 'package:readysethire/screens/toolscreen/history_services.dart' show HistoryService;
//
// import '../../../theme/app_theme.dart';
// import '../../../widgets/gradient_background.dart' show GradientBackground;
// import '../aptitude_game.dart';
//
//
//
// // --- Custom Painter Widgets for Question 1 ---
//
// class _Question1SequenceBoxPainter extends CustomPainter {
//   final List<Rect> squares;
//   final Rect circle;
//
//   _Question1SequenceBoxPainter({required this.squares, required this.circle});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final framePaint = Paint()
//       ..color = const Color(0xFF000000)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 0.5;
//     final squarePaint = Paint()..color = const Color(0xFF000000);
//     final circlePaint = Paint()
//       ..color = const Color(0xFF000000)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.0;
//
//     canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), framePaint);
//     canvas.drawOval(circle, circlePaint);
//     for (final rect in squares) {
//       canvas.drawRect(rect, squarePaint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
// class _SequenceBox extends StatelessWidget {
//   final List<Rect> squares;
//   final Rect circle;
//   const _SequenceBox({required this.squares, required this.circle});
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: const Size(60, 60),
//       painter: _Question1SequenceBoxPainter(squares: squares, circle: circle),
//     );
//   }
// }
//
// class _Question1SequenceWidget extends StatelessWidget {
//   const _Question1SequenceWidget();
//   @override
//   Widget build(BuildContext context) {
//     return const Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _SequenceBox(circle: Rect.fromLTWH(43, 43, 15, 15), squares: []),
//         _SequenceBox(
//             circle: Rect.fromLTWH(4, 43, 15, 15),
//             squares: [Rect.fromLTWH(19, 25, 10, 10)]),
//         _SequenceBox(circle: Rect.fromLTWH(43, 43, 15, 15), squares: [
//           Rect.fromLTWH(23, 17, 10, 10),
//           Rect.fromLTWH(9, 43, 10, 10)
//         ]),
//         _SequenceBox(circle: Rect.fromLTWH(3, 43, 15, 15), squares: [
//           Rect.fromLTWH(23, 17, 10, 10),
//           Rect.fromLTWH(46, 10, 10, 10),
//           Rect.fromLTWH(33, 35, 10, 10)
//         ]),
//         _SequenceBox(circle: Rect.fromLTWH(42, 43, 15, 15), squares: [
//           Rect.fromLTWH(17, 5, 10, 10),
//           Rect.fromLTWH(9, 22, 10, 10),
//           Rect.fromLTWH(38, 10, 10, 10),
//           Rect.fromLTWH(25, 35, 10, 10)
//         ]),
//       ],
//     );
//   }
// }
//
// // --- Custom Painter Widgets for Question 1 Answer Options ---
// class _Q1AnswerBoxPainter extends CustomPainter {
//   final List<Rect> squares;
//   final Rect circle;
//   _Q1AnswerBoxPainter({required this.squares, required this.circle});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final framePaint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 0.5;
//     final squarePaint = Paint()..color = Colors.black;
//     final circlePaint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.0;
//
//     canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), framePaint);
//     canvas.drawOval(circle, circlePaint);
//     for (final rect in squares) {
//       canvas.drawRect(rect, squarePaint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
// class _Q1OptionAWidget extends StatelessWidget {
//   const _Q1OptionAWidget();
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: CustomPaint(
//         size: const Size(60, 60),
//         painter: _Q1AnswerBoxPainter(
//           circle: const Rect.fromLTWH(4, 43, 15, 15),
//           squares: const [
//             Rect.fromLTWH(43, 11, 10, 10),
//             Rect.fromLTWH(10, 19.5, 10, 10),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _Q1OptionBWidget extends StatelessWidget {
//   const _Q1OptionBWidget();
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: CustomPaint(
//         size: const Size(60, 60),
//         painter: _Q1AnswerBoxPainter(
//           circle: const Rect.fromLTWH(3, 43, 15, 15),
//           squares: const [
//             Rect.fromLTWH(8, 15, 10, 10),
//             Rect.fromLTWH(34, 21, 10, 10),
//             Rect.fromLTWH(29, 43, 10, 10),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _Q1OptionCWidget extends StatelessWidget {
//   const _Q1OptionCWidget();
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: CustomPaint(
//         size: const Size(60, 60),
//         painter: _Q1AnswerBoxPainter(
//           circle: const Rect.fromLTWH(5, 43, 15, 15),
//           squares: const [
//             Rect.fromLTWH(10, 10, 10, 10),
//             Rect.fromLTWH(25, 22, 10, 10),
//             Rect.fromLTWH(38, 5, 10, 10),
//             Rect.fromLTWH(43, 25, 10, 10),
//             Rect.fromLTWH(32, 43, 10, 10),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _Q1OptionDWidget extends StatelessWidget {
//   const _Q1OptionDWidget();
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: CustomPaint(
//         size: const Size(60, 60),
//         painter: _Q1AnswerBoxPainter(
//           circle: const Rect.fromLTWH(6, 43, 15, 15),
//           squares: const [
//             Rect.fromLTWH(8, 10, 10, 10),
//             Rect.fromLTWH(13, 25, 10, 10),
//             Rect.fromLTWH(46, 10, 10, 10),
//             Rect.fromLTWH(29, 20, 10, 10),
//             Rect.fromLTWH(39, 36, 10, 10),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // --- Custom Painter Widgets for Question 2 ---
//
// class _Q2Painter extends CustomPainter {
//   final bool hasInnerSquare;
//   final Offset diamondPosition;
//   final Offset innerSquarePosition;
//
//   _Q2Painter(
//       {required this.hasInnerSquare,
//         required this.diamondPosition,
//         required this.innerSquarePosition});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final borderPaint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.0;
//     final fillPaint = Paint()..color = Colors.black;
//
//     canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), borderPaint);
//     canvas.drawOval(
//         Rect.fromLTWH(1, 1, size.width - 2, size.height - 2), borderPaint);
//     canvas.drawLine(Offset(size.width / 2, 0),
//         Offset(size.width / 2, size.height), borderPaint);
//     canvas.drawLine(Offset(0, size.height / 2),
//         Offset(size.width, size.height / 2), borderPaint);
//
//     if (hasInnerSquare) {
//       canvas.drawRect(
//           Rect.fromCenter(center: innerSquarePosition, width: 13, height: 13),
//           borderPaint);
//     }
//
//     final path = Path();
//     path.moveTo(diamondPosition.dx, diamondPosition.dy - 6);
//     path.lineTo(diamondPosition.dx + 6, diamondPosition.dy);
//     path.lineTo(diamondPosition.dx, diamondPosition.dy + 6);
//     path.lineTo(diamondPosition.dx - 6, diamondPosition.dy);
//     path.close();
//     canvas.drawPath(path, fillPaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
// class _Q2BoxWidget extends StatelessWidget {
//   final bool hasInnerSquare;
//   final Offset diamondPosition;
//   final Offset innerSquarePosition;
//   const _Q2BoxWidget(
//       {required this.hasInnerSquare,
//         required this.diamondPosition,
//         this.innerSquarePosition = Offset.zero});
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: const Size(60, 60),
//       painter: _Q2Painter(
//         hasInnerSquare: hasInnerSquare,
//         diamondPosition: diamondPosition,
//         innerSquarePosition: innerSquarePosition,
//       ),
//     );
//   }
// }
//
// class _Question2SequenceWidget extends StatelessWidget {
//   const _Question2SequenceWidget();
//   @override
//   Widget build(BuildContext context) {
//     return const Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _Q2BoxWidget(
//             hasInnerSquare: true,
//             diamondPosition: Offset(15, 45),
//             innerSquarePosition: Offset(45, 15)),
//         _Q2BoxWidget(hasInnerSquare: false, diamondPosition: Offset(15, 15)),
//         _Q2BoxWidget(hasInnerSquare: false, diamondPosition: Offset(45, 15)),
//         _Q2BoxWidget(
//             hasInnerSquare: true,
//             diamondPosition: Offset(45, 45),
//             innerSquarePosition: Offset(45, 15)),
//         _Q2BoxWidget(hasInnerSquare: false, diamondPosition: Offset(15, 45)),
//       ],
//     );
//   }
// }
//
// // --- Custom Painter Widgets for Question 3 ---
// class _TrianglePainter extends CustomPainter {
//   final double rotation;
//   _TrianglePainter({this.rotation = 0});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = Colors.black;
//     final path = Path();
//     path.moveTo(size.width * 0.2, size.height * 0.2);
//     path.lineTo(size.width * 0.2, size.height * 0.8);
//     path.lineTo(size.width * 0.8, size.height * 0.5);
//     path.close();
//
//     canvas.save();
//     canvas.translate(size.width / 2, size.height / 2);
//     canvas.rotate(rotation);
//     canvas.translate(-size.width / 2, -size.height / 2);
//     canvas.drawPath(path, paint);
//     canvas.restore();
//   }
//
//   @override
//   bool shouldRepaint(_TrianglePainter oldDelegate) =>
//       oldDelegate.rotation != rotation;
// }
//
// class _RotatedTriangleBox extends StatelessWidget {
//   final double angle;
//   const _RotatedTriangleBox({required this.angle});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(2),
//       decoration:
//       BoxDecoration(border: Border.all(color: Colors.black, width: 0.5)),
//       child: CustomPaint(
//         size: const Size(40, 40),
//         painter: _TrianglePainter(rotation: angle * math.pi / 180),
//       ),
//     );
//   }
// }
//
// class _Question3SequenceWidget extends StatelessWidget {
//   const _Question3SequenceWidget();
//   @override
//   Widget build(BuildContext context) {
//     return const Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _RotatedTriangleBox(angle: 0),
//         _RotatedTriangleBox(angle: 45),
//         _RotatedTriangleBox(angle: 90),
//         _RotatedTriangleBox(angle: 135),
//         _RotatedTriangleBox(angle: 180),
//       ],
//     );
//   }
// }
//
// class _Q3Option2Widget extends StatelessWidget {
//   const _Q3Option2Widget();
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: CustomPaint(
//             size: const Size(60, 60),
//             painter: _TrianglePainter(rotation: 225 * math.pi / 180)));
//   }
// }
//
// // --- Widgets for Question 4 ---
// enum ShapeType {
//   arrowOutline,
//   arrowSolid,
//   pentagonOutline,
//   pentagonSolid,
//   semicircleOutline,
//   semicircleSolid,
//   arcOutline,
// }
//
// class ShapePainter extends CustomPainter {
//   final ShapeType shapeType;
//   ShapePainter({required this.shapeType});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..strokeWidth = 2;
//     switch (shapeType) {
//       case ShapeType.arrowOutline:
//         paint
//           ..color = Colors.black
//           ..style = PaintingStyle.stroke
//           ..strokeCap = StrokeCap.round
//           ..strokeJoin = StrokeJoin.round;
//         final path = Path();
//         path.moveTo(size.width * 0.5, size.height * 0.79);
//         path.lineTo(size.width * 0.5, size.height * 0.25);
//         path.moveTo(size.width * 0.5, size.height * 0.25);
//         path.lineTo(size.width * 0.25, size.height * 0.5);
//         path.moveTo(size.width * 0.5, size.height * 0.25);
//         path.lineTo(size.width * 0.75, size.height * 0.5);
//         canvas.drawPath(path, paint);
//         break;
//       case ShapeType.arrowSolid:
//         paint
//           ..color = Colors.black
//           ..style = PaintingStyle.fill;
//         final path = Path();
//         path.moveTo(size.width * 0.5, size.height * 0.16);
//         path.lineTo(size.width * 0.25, size.height * 0.41);
//         path.lineTo(size.width * 0.41, size.height * 0.41);
//         path.lineTo(size.width * 0.41, size.height * 0.79);
//         path.lineTo(size.width * 0.58, size.height * 0.79);
//         path.lineTo(size.width * 0.58, size.height * 0.41);
//         path.lineTo(size.width * 0.75, size.height * 0.41);
//         path.close();
//         canvas.drawPath(path, paint);
//         break;
//       case ShapeType.pentagonOutline:
//       case ShapeType.pentagonSolid:
//         paint
//           ..color = Colors.black
//           ..style = (shapeType == ShapeType.pentagonSolid)
//               ? PaintingStyle.fill
//               : PaintingStyle.stroke;
//         final path = Path();
//         path.moveTo(size.width * 0.5, size.height * 0.08);
//         path.lineTo(size.width * 0.79, size.height * 0.35);
//         path.lineTo(size.width * 0.66, size.height * 0.83);
//         path.lineTo(size.width * 0.33, size.height * 0.83);
//         path.lineTo(size.width * 0.21, size.height * 0.35);
//         path.close();
//         canvas.drawPath(path, paint);
//         break;
//       case ShapeType.semicircleSolid:
//       case ShapeType.semicircleOutline:
//       case ShapeType.arcOutline:
//         paint.color = Colors.black;
//         if (shapeType == ShapeType.semicircleSolid) {
//           paint.style = PaintingStyle.fill;
//         } else {
//           paint.style = PaintingStyle.stroke;
//         }
//         final rect = Rect.fromCircle(
//             center: Offset(size.width / 2, size.height * 0.66),
//             radius: size.width * 0.33);
//         if (shapeType == ShapeType.arcOutline) {
//           canvas.drawArc(rect, math.pi, -math.pi, false, paint);
//         } else {
//           final path = Path();
//           path.arcTo(rect, math.pi, -math.pi, false);
//           path.close();
//           canvas.drawPath(path, paint);
//         }
//         break;
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
// class _Question4SequenceWidget extends StatelessWidget {
//   const _Question4SequenceWidget();
//   Widget _buildSequenceBox({required ShapeType shape}) {
//     return Container(
//       width: 56,
//       height: 56,
//       decoration: BoxDecoration(
//           color: Colors.white, border: Border.all(color: Colors.grey.shade400)),
//       child: Center(
//         child: SizedBox(
//             width: 24,
//             height: 24,
//             child: CustomPaint(painter: ShapePainter(shapeType: shape))),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _buildSequenceBox(shape: ShapeType.arrowOutline),
//         _buildSequenceBox(shape: ShapeType.arrowSolid),
//         _buildSequenceBox(shape: ShapeType.pentagonOutline),
//         _buildSequenceBox(shape: ShapeType.pentagonSolid),
//         _buildSequenceBox(shape: ShapeType.arcOutline),
//       ],
//     );
//   }
// }
//
// class _Q4OptionWidget extends StatelessWidget {
//   final ShapeType shape;
//   const _Q4OptionWidget({required this.shape});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SizedBox(
//         width: 48,
//         height: 48,
//         child: CustomPaint(painter: ShapePainter(shapeType: shape)),
//       ),
//     );
//   }
// }
//
// // --- Widgets for Question 5 ---
// enum Q5ShapeType { circle, square, triangle }
// enum Q5InnerLineType { none, vertical, plus }
//
// class _Q5ShapePainter extends CustomPainter {
//   final Q5ShapeType shape;
//   final Q5InnerLineType lines;
//   _Q5ShapePainter({required this.shape, required this.lines});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 1.5
//       ..style = PaintingStyle.stroke;
//
//     switch (shape) {
//       case Q5ShapeType.circle:
//         canvas.drawCircle(
//             Offset(size.width / 2, size.height / 2), size.width / 2 - 1, paint);
//         break;
//       case Q5ShapeType.square:
//         canvas.drawRect(
//             Rect.fromLTWH(1, 1, size.width - 2, size.height - 2), paint);
//         break;
//       case Q5ShapeType.triangle:
//         final path = Path();
//         path.moveTo(size.width / 2, 1);
//         path.lineTo(size.width - 1, size.height - 1);
//         path.lineTo(1, size.height - 1);
//         path.close();
//         canvas.drawPath(path, paint);
//         break;
//     }
//
//     final linePaint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 1.5;
//     switch (lines) {
//       case Q5InnerLineType.vertical:
//         canvas.drawLine(Offset(size.width / 2, 0),
//             Offset(size.width / 2, size.height), linePaint);
//         break;
//       case Q5InnerLineType.plus:
//         canvas.drawLine(Offset(size.width / 2, 0),
//             Offset(size.width / 2, size.height), linePaint);
//         canvas.drawLine(Offset(0, size.height / 2),
//             Offset(size.width, size.height / 2), linePaint);
//         break;
//       case Q5InnerLineType.none:
//       default:
//         break;
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
// class _Q5ShapeWidget extends StatelessWidget {
//   final Q5ShapeType shape;
//   final Q5InnerLineType lines;
//   const _Q5ShapeWidget({required this.shape, required this.lines});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 50,
//       height: 50,
//       child: CustomPaint(painter: _Q5ShapePainter(shape: shape, lines: lines)),
//     );
//   }
// }
//
// class _Question5SequenceWidget extends StatelessWidget {
//   const _Question5SequenceWidget();
//   @override
//   Widget build(BuildContext context) {
//     return const Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _Q5ShapeWidget(shape: Q5ShapeType.circle, lines: Q5InnerLineType.none),
//         _Q5ShapeWidget(
//             shape: Q5ShapeType.circle, lines: Q5InnerLineType.vertical),
//         _Q5ShapeWidget(shape: Q5ShapeType.circle, lines: Q5InnerLineType.plus),
//         _Q5ShapeWidget(shape: Q5ShapeType.square, lines: Q5InnerLineType.plus),
//         _Q5ShapeWidget(
//             shape: Q5ShapeType.square, lines: Q5InnerLineType.vertical),
//       ],
//     );
//   }
// }
//
// // --- Test Data ---
// class DiagrammaticTestData {
//   static List<DiagrammaticQuestion> diagrammaticReasoningQuestions = [
//     DiagrammaticQuestion(
//         questionText: 'Which of the boxes comes next in the sequence?',
//         questionContent: const _Question1SequenceWidget(),
//         options: [
//           const _Q1OptionAWidget(),
//           const _Q1OptionBWidget(),
//           const _Q1OptionCWidget(),
//           const _Q1OptionDWidget(),
//         ],
//         correctOptionIndex: 3,
//         solutionText:
//         "The number of squares increases by one with each turn. The circle moves from the bottom right corner to the bottom left corner with each turn."),
//     DiagrammaticQuestion(
//         questionText: 'Which of the boxes comes next in the sequence?',
//         questionContent: const _Question2SequenceWidget(),
//         options: [
//           const Center(
//               child: _Q2BoxWidget(
//                   hasInnerSquare: true,
//                   diamondPosition: Offset(15, 15),
//                   innerSquarePosition: Offset(45, 45))),
//           const Center(
//               child: _Q2BoxWidget(
//                   hasInnerSquare: false, diamondPosition: Offset(15, 15))),
//           const Center(
//               child: _Q2BoxWidget(
//                   hasInnerSquare: true,
//                   diamondPosition: Offset(45, 45),
//                   innerSquarePosition: Offset(15, 15))),
//           const Center(
//               child: _Q2BoxWidget(
//                   hasInnerSquare: true,
//                   diamondPosition: Offset(45, 15),
//                   innerSquarePosition: Offset(15, 45))),
//         ],
//         correctOptionIndex: 1,
//         solutionText:
//         "The dot moves clockwise between quadrants. The inner square appears for one turn, then is absent for the next two turns. Following the pattern, the next shape should have the dot in the Top-Left quadrant and NO inner square."),
//     DiagrammaticQuestion(
//       questionText: 'Which of the boxes comes next in the sequence?',
//       questionContent: const _Question3SequenceWidget(),
//       options: [
//         const _Q1OptionAWidget(), // Placeholder
//         const _Q3Option2Widget(), // Correct
//         const _Q1OptionBWidget(), // Placeholder
//         const _Q1OptionCWidget(), // Placeholder
//       ],
//       correctOptionIndex: 1,
//       solutionText:
//       "The triangle rotates 45 degrees clockwise with each turn. The next rotation after 180 degrees is 225 degrees.",
//     ),
//     DiagrammaticQuestion(
//       questionText: 'Which of the boxes comes next in the sequence?',
//       questionContent: const _Question4SequenceWidget(),
//       options: [
//         const _Q4OptionWidget(shape: ShapeType.semicircleSolid),
//         const _Q4OptionWidget(shape: ShapeType.pentagonSolid),
//         const _Q4OptionWidget(shape: ShapeType.arcOutline),
//         const _Q4OptionWidget(shape: ShapeType.arrowSolid),
//       ],
//       correctOptionIndex: 0,
//       solutionText:
//       "The pattern alternates between an outlined shape and its solid counterpart. After the outlined arc, the next logical shape is the solid version, which is the semicircle.",
//     ),
//     DiagrammaticQuestion(
//       questionText: 'Which of the shapes comes next in the sequence?',
//       questionContent: const _Question5SequenceWidget(),
//       options: [
//         const Center(
//             child: _Q5ShapeWidget(
//                 shape: Q5ShapeType.square, lines: Q5InnerLineType.none)),
//         const Center(
//             child: _Q5ShapeWidget(
//                 shape: Q5ShapeType.circle, lines: Q5InnerLineType.none)),
//         const Center(
//             child: _Q5ShapeWidget(
//                 shape: Q5ShapeType.triangle,
//                 lines: Q5InnerLineType.vertical)),
//         const Center(
//             child: _Q5ShapeWidget(
//                 shape: Q5ShapeType.square, lines: Q5InnerLineType.plus)),
//       ],
//       correctOptionIndex: 0,
//       solutionText:
//       "The sequence first shows a shape with no lines, then adds a vertical line, then a horizontal line to make a plus. It then transitions to a new shape, repeating the line pattern in reverse (plus, then vertical). The final shape should be a square with no lines.",
//     ),
//   ];
// }
//
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
// class SolutionDialog extends StatelessWidget {
//   final bool isCorrect;
//   final String solutionText;
//   final VoidCallback onOkPressed;
//
//   const SolutionDialog({
//     super.key,
//     required this.isCorrect,
//     required this.solutionText,
//     required this.onOkPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.all(16),
//       child: Container(
//         width: 314,
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//         constraints: const BoxConstraints(maxHeight: 315),
//         decoration: BoxDecoration(
//             color: const Color(0xFFFFE0EE),
//             borderRadius: BorderRadius.circular(10)),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(isCorrect ? Icons.check_circle : Icons.cancel,
//                 color: isCorrect ? Colors.green : Colors.red, size: 54),
//             const SizedBox(height: 16),
//             Text(isCorrect ? 'Correct!' : 'Wrong!',
//                 style: GoogleFonts.b612Mono(
//                     fontWeight: FontWeight.w700,
//                     fontSize: 20,
//                     color: const Color(0xFF3F3F3F))),
//             const SizedBox(height: 16),
//             Flexible(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25),
//                   child: Text(
//                     solutionText,
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.b612Mono(
//                         fontWeight: FontWeight.w700,
//                         fontSize: 11,
//                         color: const Color(0xFF3F3F3F),
//                         height: 1.8),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: onOkPressed,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFE8A0BF),
//                 foregroundColor: const Color(0xFF491D7F),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30)),
//                 padding:
//                 const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//                 elevation: 4,
//               ),
//               child: Text('Ok',
//                   style: GoogleFonts.b612Mono(
//                       fontWeight: FontWeight.w700, fontSize: 15)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class DiagrammaticReasoningTestScreen extends StatefulWidget {
//   const DiagrammaticReasoningTestScreen({super.key});
//
//   @override
//   State<DiagrammaticReasoningTestScreen> createState() =>
//       _DiagrammaticReasoningTestScreenState();
// }
//
// class _DiagrammaticReasoningTestScreenState
//     extends State<DiagrammaticReasoningTestScreen> {
//   // Use a mutable list to hold the shuffled questions.
//   late List<DiagrammaticQuestion> questions;
//   int _currentIndex = 0;
//   int _score = 0;
//   int? _selectedOption;
//   Timer? _timer;
//   int _secondsRemaining = 30;
//   bool _isAnswered = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Shuffle the questions when the screen is initialized.
//     questions = List.of(DiagrammaticTestData.diagrammaticReasoningQuestions)..shuffle();
//     startTimer();
//   }
//
//   void startTimer() {
//     _timer?.cancel();
//     setState(() {
//       _secondsRemaining = 30;
//       _isAnswered = false;
//       _selectedOption = null;
//     });
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (!mounted) {
//         timer.cancel();
//         return;
//       }
//       if (_secondsRemaining > 0) {
//         setState(() => _secondsRemaining--);
//       } else {
//         timer.cancel();
//         _handleOptionSelection(-1);
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
//   void _handleOptionSelection(int index) {
//     if (_isAnswered) return;
//     _timer?.cancel();
//
//     setState(() {
//       _selectedOption = index;
//       _isAnswered = true;
//     });
//
//     final currentQuestion = questions[_currentIndex];
//     final isCorrect = index == currentQuestion.correctOptionIndex;
//
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return SolutionDialog(
//           isCorrect: isCorrect,
//           solutionText: currentQuestion.solutionText,
//           onOkPressed: () {
//             Navigator.of(context).pop();
//             _handleNextChallenge();
//           },
//         );
//       },
//     );
//   }
//
//   // +++ THIS METHOD IS NOW UPDATED +++
//   void _handleNextChallenge() {
//     if (_selectedOption != null &&
//         _selectedOption == questions[_currentIndex].correctOptionIndex) {
//       _score++;
//     }
//
//     if (_currentIndex < questions.length - 1) {
//       setState(() => _currentIndex++);
//       startTimer();
//     } else {
//       // --- SAVE THE RESULT ---
//       final result = TestResult(
//         type: 'Aptitude Game',
//         name: 'Diagrammatic Reasoning', // Correct name for the test
//         score: ( _score / questions.length) * 100,
//         rawScore: _score,
//         totalQuestions: questions.length,
//         date: DateTime.now(),
//       );
//       HistoryService.saveResult(result);
//
//       // --- NAVIGATE TO THE NEW, CENTRALIZED RESULTS SCREEN ---
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => AptitudeResultsScreen(
//             score: _score,
//             totalQuestions: questions.length,
//             testName: "Diagrammatic Reasoning Test",
//           ),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final DiagrammaticQuestion currentQuestion = questions[_currentIndex];
//     return GradientBackground(
//       child: Scaffold(
//         body: SafeArea(
//           child: LayoutBuilder(
//             builder: (context, viewportConstraints) {
//               return SingleChildScrollView(
//                 child: ConstrainedBox(
//                   constraints:
//                   BoxConstraints(minHeight: viewportConstraints.maxHeight),
//                   child: Padding(
//                     padding: const EdgeInsets.all(24.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const GameAppHeader(),
//                         const SizedBox(height: 24),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Expanded(
//                                 child: Text(currentQuestion.questionText,
//                                     style:
//                                     Theme.of(context).textTheme.bodyLarge)),
//                             const SizedBox(width: 16),
//                             CircularTimer(seconds: _secondsRemaining),
//                           ],
//                         ),
//                         if (currentQuestion.questionContent != null)
//                           Padding(
//                               padding:
//                               const EdgeInsets.symmetric(vertical: 16.0),
//                               child: currentQuestion.questionContent!),
//                         const SizedBox(height: 24),
//                         GridView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 16,
//                             mainAxisSpacing: 16,
//                             childAspectRatio: 146 / 133,
//                           ),
//                           itemCount: currentQuestion.options.length,
//                           itemBuilder: (context, index) {
//                             final isSelected = _selectedOption == index;
//                             final isCorrect =
//                                 index == currentQuestion.correctOptionIndex;
//                             Color borderColor = const Color(0xFF747474);
//                             double borderWidth = 1.0;
//                             if (_isAnswered) {
//                               if (isCorrect) {
//                                 borderColor = Colors.green;
//                                 borderWidth = 2.0;
//                               } else if (isSelected && !isCorrect) {
//                                 borderColor = Colors.red;
//                                 borderWidth = 2.0;
//                               }
//                             }
//                             return GestureDetector(
//                               onTap: () => _handleOptionSelection(index),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFFFFD4E7),
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                       color: borderColor, width: borderWidth),
//                                 ),
//                                 child: currentQuestion.options[index],
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
