import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musify/feature/account/data/models/user/recently_played.dart';

class ListeningDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ListeningDataSource(this.firestore, this.auth);

  String? get uid => auth.currentUser?.uid;

  DocumentReference get userDoc => firestore.collection('users').doc(uid);

  CollectionReference<Map<String, dynamic>> get recentlyPlayedCol =>
      userDoc.collection('recentlyPlayed');

  CollectionReference<Map<String, dynamic>> get recentlyPlayedHistoryCol =>
      userDoc.collection('recentlyPlayedHistory');

  Future<void> playCountIncrement(String songId) async {
    await firestore.collection('songs').doc(songId).update({
      'stats.playCount': FieldValue.increment(1),
    });
  }

  Future<void> addRecentlyPlayed({
    required RecentlyPlayed recentlyPlayed,
    required bool canUpdate,
    String? docToBeDeleted,
  }) async {
    if (uid == null) return;

    if (canUpdate) {
      recentlyPlayedCol
          .doc(recentlyPlayed.songId)
          .update(recentlyPlayed.toFirebase());
    } else {
      if (docToBeDeleted != null) {
        recentlyPlayedCol.doc(docToBeDeleted).delete();
      }
      recentlyPlayedCol
          .doc(recentlyPlayed.songId)
          .set(recentlyPlayed.toFirebase());
    }
  }

  Future<void> addRecentlyPlayedHistory(RecentlyPlayedHistory history) async {
    if (uid == null) return;
    await recentlyPlayedHistoryCol.doc(history.id).set(history.toFirebase());
  }
}
