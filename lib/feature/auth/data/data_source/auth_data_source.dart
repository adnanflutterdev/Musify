import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musify/feature/auth/domain/usecase/login_usecase.dart';
import 'package:musify/feature/auth/domain/usecase/signup_usecase.dart';
import 'package:musify/feature/user/data/models/user_data.dart';

class AuthDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthDataSource({required this.auth, required this.firestore});

  Future<void> login(LoginParams params) async {
    await auth.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }

  Future<UserCredential> signup(SignupParams params) async {
    return await auth.createUserWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }

  Future<void> setUserData(SignupParams params) async {
    final userData = UserData.setNewUser(
      name: params.name,
      email: params.email,
    ).toFirestore();
    await firestore.collection('users').doc().set(userData);
  }
}
