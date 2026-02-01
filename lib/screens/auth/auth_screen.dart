import 'package:flutter/material.dart';
import 'package:musify/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musify/screens/auth/login_signup.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          }
          return LoginSignup();
        },
      ),
    );
  }
}
