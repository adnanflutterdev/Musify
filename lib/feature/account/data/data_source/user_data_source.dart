import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musify/feature/account/data/models/user/recently_played.dart';
import 'package:musify/feature/account/data/models/user/user_data.dart';
import 'package:musify/feature/account/data/models/user/username.dart';

class UserDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UserDataSource(this.auth, this.firestore);

  String? get uid => auth.currentUser?.uid;

  DocumentReference get userDoc => firestore.collection('users').doc(uid);

  CollectionReference<Map<String, dynamic>> get recentlyPlayedCol =>
      userDoc.collection('recentlyPlayed');

  CollectionReference<Map<String, dynamic>> get recentlyPlayedHistoryCol =>
      userDoc.collection('recentlyPlayedHistory');

  Future<UserData?> getUserData() async {
    if (uid == null) return null;
    final user = await userDoc.get();

    if (!user.exists || user.data() == null) return null;
    return UserData.fromFirestore(user);
  }

  Future<void> updateUserData(Map<String, dynamic> updatedData) async {
    if (uid == null) return;
    await userDoc.update(updatedData);
  }

  Future<bool> isUserNameAvailable(String username) async {
    final doc = await firestore.collection('usernames').doc(username).get();

    return !doc.exists;
  }

  Future<void> deleteUsername(String username) async {
    await firestore.collection('usernames').doc(username).delete();
  }

  Future<void> setUsername(Username username) async {
    await firestore
        .collection('usernames')
        .doc(username.id)
        .set(username.toFirebase());
  }

  // Get users music data

  Future<List<RecentlyPlayed>> getRecentlyPlayed() async {
    final recentlyPlayed = await recentlyPlayedCol
        .orderBy('playedAt', descending: true)
        .get();
    return recentlyPlayed.docs
        .map((e) => RecentlyPlayed.fromFirebase(e.data()))
        .toList();
  }

  Future<List<RecentlyPlayedHistory>> getRecentlyPlayedHistory() async {
    final history = await recentlyPlayedHistoryCol
        .orderBy('endedAt', descending: true)
        .get();
    return history.docs
        .map((e) => RecentlyPlayedHistory.fromFirebase(e.data()))
        .toList();
  }
}
