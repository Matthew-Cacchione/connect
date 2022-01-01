import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../functions/user_service.dart';
import 'alerts.dart';

// Authentication

Future<void> signIn(String email, String password, GlobalKey<FormState> formKey, BuildContext context) async {
  if (formKey.currentState!.validate()) {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        Navigator.pushReplacementNamed(context, '/');
      } else {
        Navigator.pushNamed(context, '/verification');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = defaultError;

      if (e.code == 'user-not-found') {
        errorMessage = userNotFound;
      } else if (e.code == 'wrong-password') {
        errorMessage = wrongPassword;
      }

      showErrorSnackBar(errorMessage, context);
    }
  }
}

Future<void> signUp(String email, String password, String name, GlobalKey<FormState> formKey, BuildContext context) async {
  if (formKey.currentState!.validate()) {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      setInitialData(name, context);
    } on FirebaseAuthException catch (e) {
      var errorMessage = defaultError;

      if (e.code == 'weak-password') {
        errorMessage = passwordStrengthError;
      } else if (e.code == 'email-already-in-use') {
        errorMessage = emailInUseError;
        Navigator.pushReplacementNamed(context, '/login');
      }

      showErrorSnackBar(errorMessage, context);
    } catch (e) {
      showErrorSnackBar(defaultError, context);
    }
  }
}

Future<void> signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacementNamed(context, '/login');
}

Future<void> resetUserPassword(String email, BuildContext context) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  } on FirebaseAuthException catch (e) {
    String errorMessage = defaultError;

    if (e.code == 'invalid-email') {
      errorMessage = emailNotValid;
    } else if (e.code == 'user-not-found') {
      errorMessage = userNotFound;
    }
    showErrorSnackBar(errorMessage, context);
  }
}
