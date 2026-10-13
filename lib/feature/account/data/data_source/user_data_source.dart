import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musify/feature/account/data/models/user_data.dart';
import 'package:musify/feature/account/data/models/username.dart';

class UserDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UserDataSource(this.auth, this.firestore);

  String? get uid => auth.currentUser?.uid;

  Future<UserData?> getUserData() async {
    if (uid == null) return null;
    final user = await firestore.collection('users').doc(uid).get();

    if (!user.exists || user.data() == null) return null;
    return UserData.fromFirestore(user);
  }

  Future<void> updateUserData(Map<String, dynamic> updatedData) async {
    if (uid == null) return;
    await firestore.collection('users').doc(uid).update(updatedData);
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
}
