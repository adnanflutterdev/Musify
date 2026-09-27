import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/feature/user/data/models/user_data.dart';

final userDataProvider = StreamProvider<UserData>((ref) {
  return FirebaseFirestore.instance
      .collection('userData')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots()
      .map((documentSnapshot) => UserData.fromFirestore(documentSnapshot));
});
