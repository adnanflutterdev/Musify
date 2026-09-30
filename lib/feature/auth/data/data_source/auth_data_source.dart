import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:musify/feature/auth/domain/usecase/login_usecase.dart';
import 'package:musify/feature/auth/domain/usecase/signup_usecase.dart';
import 'package:musify/feature/user/data/models/user_data.dart';
import 'package:musify/secrets.dart';

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

  Future<UserCredential> googleSignIn() async {
    final signIn = GoogleSignIn.instance;
    await signIn.initialize(serverClientId: webClientId);

    GoogleSignInAccount google = await signIn.authenticate();

    OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
      idToken: google.authentication.idToken,
    );

    return auth.signInWithCredential(oAuthCredential);
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<void> setUserData({SignupParams? params, required User user}) async {
    final userData = UserData.setNewUser(
      uid: user.uid,
      name: params?.name ?? user.displayName ?? '',
      email: params?.email ?? user.email ?? '',
    ).toFirestore();
    await firestore.collection('users').doc(user.uid).set(userData);
  }

  Future<bool> userExists(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    return doc.exists;
  }

  Future<void> sendEmailVerificationLink() async {
    await auth.currentUser?.sendEmailVerification();
  }
}
