import 'package:cloud_firestore/cloud_firestore.dart';

class TestResult {
  /// The unique ID of the document from Firestore.
  final String? id;
  final String type;
  final String name;
  final DateTime date;
  final double score;
  // MODIFIED: Made these optional to support results without raw scores, like mock interviews.
  final int? rawScore;
  final int? totalQuestions;
  final String? feedback;
  // Optional per-category percentage breakdown (e.g., {'Communication': 80.0})
  final Map<String, double>? categoryPercentages;

  TestResult({
    this.id,
    required this.type,
    required this.name,
    required this.date,
    required this.score,
    // MODIFIED: These are no longer required.
    this.rawScore,
    this.totalQuestions,
    this.feedback,
    this.categoryPercentages,
  });

  /// Factory constructor to create a TestResult from a Firestore document snapshot.
  factory TestResult.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;

    // Read categoryPercentages if present and convert numeric values to double
    Map<String, double>? readCategoryPercentages(Map<String, dynamic>? raw) {
      if (raw == null) return null;
      final Map<String, double> out = {};
      raw.forEach((k, v) {
        if (v is num) {
          out[k] = v.toDouble();
        } else if (v is String) {
          final parsed = double.tryParse(v);
          if (parsed != null) out[k] = parsed;
        }
      });
      return out.isEmpty ? null : out;
    }

    return TestResult(
      id: doc.id,
      type: data['type'] ?? 'Unknown Type',
      name: data['name'] ?? 'Untitled',
      date: (data['date'] as Timestamp).toDate(),
      score: (data['score'] as num).toDouble(),
      // MODIFIED: Safely read these optional fields from Firestore.
      rawScore: data['rawScore'],
      totalQuestions: data['totalQuestions'],
      feedback: data['feedback'],
      categoryPercentages: readCategoryPercentages(
          (data['categoryPercentages'] as Map<String, dynamic>?)),
    );
  }

  /// Converts a TestResult instance into a Map for storing in Firestore.
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'date': Timestamp.fromDate(date), // Use Firestore's Timestamp for querying
      'score': score,
      // MODIFIED: Include these fields in the JSON only if they are not null.
      if (rawScore != null) 'rawScore': rawScore,
      if (totalQuestions != null) 'totalQuestions': totalQuestions,
      if (feedback != null) 'feedback': feedback,
      if (categoryPercentages != null) 'categoryPercentages': categoryPercentages,
    };
  }
}
