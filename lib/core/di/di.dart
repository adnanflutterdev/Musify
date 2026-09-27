import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider((ref) {
  return FirebaseAuth.instance;
});

final firestoreProvider = Provider((ref) {
  return FirebaseFirestore.instance;
});
