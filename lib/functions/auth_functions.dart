import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:musify/main.dart';
import 'package:musify/screens/home_screen.dart';
import 'package:musify/widgets/snack_bars.dart';

Future<void> login({
  required GlobalKey<FormState> formKey,
  required TextEditingController email,
  required TextEditingController pass,
  required BuildContext context,
}) async {
  bool isValid = formKey.currentState!.validate();

  if (isValid) {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: pass.text.trim(),
      );
      if (!context.mounted) {
        return;
      }
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false,
      );
      showAppSnackbar(
        context: context,
        message: 'You logged in successfully...',
        snackBarType: SnackBarType.success,
      );
    } on FirebaseAuthException catch (err) {
      if (!context.mounted) {
        return;
      }
      showAppSnackbar(
        context: context,
        message: err.message!,
        snackBarType: SnackBarType.error,
      );
    }
  }
}

Future<void> signup({
  required GlobalKey<FormState> formKey,
  required TextEditingController name,
  required TextEditingController email,
  required TextEditingController pass,
  required ref,
  required BuildContext context,
}) async {
  bool isValid = formKey.currentState!.validate();

  if (isValid) {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email.text.trim(),
            password: pass.text.trim(),
          );
      final uid = credential.user!.uid;
      String downloadUrl = '';
      if (ref.image != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('userProfile')
            .child('$uid.jpg');
        await storageRef.putFile(File(ref.image!.path));
        downloadUrl = await storageRef.getDownloadURL();
      }
      await FirebaseFirestore.instance.collection('userData').doc(uid).set({
        'name': name.text,
        'dob': ref.dob,
        'gender': ref.gender,
        'image': ref.image != null ? downloadUrl : '',
        'favourite': [],
        'myAlbum': [],
        'myPlaylists': [],
        'recentlyPlayed': [],
      });
      if (!context.mounted) {
        return;
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false,
      );
      showAppSnackbar(
        context: context,
        message: 'Account created successfully...',
        snackBarType: SnackBarType.success,
      );
    } on FirebaseAuthException catch (err) {
      if (!context.mounted) {
        return;
      }
      showAppSnackbar(
        context: context,
        message: err.message!,
        snackBarType: SnackBarType.error,
      );
    }
  }
}

void logout(BuildContext context) async {
  try {
    Navigator.pop(context);
    await FirebaseAuth.instance.signOut();

    if (!context.mounted) {
      return;
    }

    RestartWidget.restartApp(context);
  } catch (err) {
    debugPrint('$err');
  }
}
