import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musify/feature/account/data/models/user_data.dart';

class UserDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UserDataSource(this.auth, this.firestore);

  Future<UserData?> getUserData() async {
    final uid = auth.currentUser?.uid;
    if (uid == null) return null;
    final user = await firestore.collection('users').doc(uid).get();

    if (!user.exists || user.data() == null) return null;
    return UserData.fromFirestore(user);
  }
}
