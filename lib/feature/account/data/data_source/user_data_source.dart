import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musify/feature/account/data/models/user/favourite_song.dart';
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

  CollectionReference<Map<String, dynamic>> get favouriteCol =>
      userDoc.collection('favourite');

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

  Stream<List<RecentlyPlayed>> getRecentlyPlayed() {
    final recentlyPlayed = recentlyPlayedCol
        .orderBy('playedAt', descending: true)
        .snapshots();
    return recentlyPlayed.map(
      (recentlyPlayed) => recentlyPlayed.docs
          .map((e) => RecentlyPlayed.fromFirebase(e.data()))
          .toList(),
    );
  }

  Future<List<RecentlyPlayedHistory>> getRecentlyPlayedHistory() async {
    final history = await recentlyPlayedHistoryCol
        .orderBy('endedAt', descending: true)
        .get();
    return history.docs
        .map((e) => RecentlyPlayedHistory.fromFirebase(e.data()))
        .toList();
  }

  Stream<List<FavouriteSong>> getFavouriteSongs() {
    final snapshots = favouriteCol.orderBy('createdAt').snapshots();
    return snapshots.map(
      (data) => data.docs
          .map((favourite) => FavouriteSong.fromFirebase(favourite.data()))
          .toList(),
    );
  }

  Future<void> toggleFavourite(String songId, bool isFavourite) async {
    if (isFavourite) {
      await favouriteCol.doc(songId).delete();
      return;
    }
    FavouriteSong favouriteSong = FavouriteSong(
      songId: songId,
      createdAt: DateTime.now(),
    );

    await favouriteCol.doc(songId).set(favouriteSong.toFirebase());
  }
}
