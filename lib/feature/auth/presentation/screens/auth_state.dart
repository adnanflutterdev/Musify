import 'package:flutter/material.dart';
import 'package:musify/core/widgets/custom_scaffold.dart';
import 'package:musify/feature/app/presentation/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musify/feature/auth/presentation/screens/auth_screen.dart';

class AuthState extends StatelessWidget {
  const AuthState({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      padding: EdgeInsets.zero,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}
