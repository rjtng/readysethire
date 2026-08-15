import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:readysethire/models/test_result_model.dart';

/// A service class to handle storing and retrieving test history from Firestore.
class HistoryService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream controller to broadcast newly saved results to interested listeners
  static final StreamController<TestResult> _newResultController = StreamController<TestResult>.broadcast();

  /// Stream that emits a TestResult whenever a new result is saved.
  static Stream<TestResult> get onNewResult => _newResultController.stream;

  /// Returns a reference to the 'history' collection for the currently logged-in user.
  /// Returns null if no user is logged in.
  static CollectionReference<Map<String, dynamic>>? _getUserHistoryCollection() {
    final user = _auth.currentUser;
    if (user == null) {
      print("HistoryService Error: No user is currently signed in.");
      return null;
    }
    // Each user gets their own 'history' sub-collection within their user document.
    return _firestore.collection('users').doc(user.uid).collection('history');
  }

  /// Fetches the list of all saved test results for the current user.
  static Future<List<TestResult>> getHistory() async {
    final collection = _getUserHistoryCollection();
    if (collection == null) return [];

    try {
      final querySnapshot = await collection.orderBy('date', descending: true).get();
      return querySnapshot.docs
          .map((doc) => TestResult.fromFirestore(doc))
          .toList();
    } catch (e) {
      print("Error fetching history from Firestore: $e");
      return []; // Return an empty list in case of an error.
    }
  }

  /// Adds a new test result to the current user's history and returns the saved TestResult
  /// (including the Firestore document id). Also emits the saved result on [onNewResult].
  static Future<TestResult?> saveResult(TestResult result) async {
    final collection = _getUserHistoryCollection();
    if (collection == null) return null;

    // Add the document and then fetch it back to get the server-side fields (like Timestamp)
    try {
      final docRef = await collection.add(result.toJson());
      final snapshot = await docRef.get();
      final saved = TestResult.fromFirestore(snapshot);
      // Emit to listeners
      _newResultController.add(saved);
      return saved;
    } catch (e) {
      print('Error saving history result: $e');
      return null;
    }
  }

  /// Deletes a specific item from the history using its Firestore document ID.
  static Future<void> deleteHistoryItem(TestResult resultToDelete) async {
    // The document ID is required to delete a specific entry.
    if (resultToDelete.id == null) {
      print("Error: Cannot delete history item without a document ID.");
      return;
    }
    final collection = _getUserHistoryCollection();
    if (collection != null) {
      await collection.doc(resultToDelete.id).delete();
    }
  }

  /// Clears all history items for the current user.
  static Future<void> clearAllHistory() async {
    final collection = _getUserHistoryCollection();
    if (collection == null) return;

    // Fetch all documents and delete them in a batch for efficiency.
    final querySnapshot = await collection.get();
    final batch = _firestore.batch();
    for (var doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
