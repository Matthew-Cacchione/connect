import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../functions/user_service.dart';
import 'alerts.dart';

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
      String _errorMessage = defaultError;
      switch (e.code) {
        case 'invalid-email':
          {
            _errorMessage = emailNotValid;
          }
          break;
        case 'user-disabled':
          {
            _errorMessage = userDisabled;
          }
          break;
        case 'user-not-found':
          {
            _errorMessage = userNotFound;
          }
          break;
        case 'wrong-password':
          {
            _errorMessage = wrongPassword;
          }
          break;
      }
      showErrorSnackBar(_errorMessage, context);
    } on Exception catch (e) {
      showErrorSnackBar(e.toString(), context);
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
      String _errorMessage = defaultError;
      switch (e.code) {
        case 'email-already-in-use':
          {
            _errorMessage = emailAlreadyInUse;
            Navigator.of(context).pushNamed('/login');
          }
          break;
        case 'invalid-email':
          {
            _errorMessage = emailNotValid;
          }
          break;
        case 'weak-password':
          {
            _errorMessage = weakPassword;
          }
          break;
      }
      showErrorSnackBar(_errorMessage, context);
    } on Exception catch (e) {
      showErrorSnackBar(e.toString(), context);
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
    showErrorSnackBar(passwordResetSent, context);
  } on FirebaseAuthException catch (e) {
    String _errorMessage = defaultError;
    switch (e.code) {
      case 'auth/invalid-email':
        {
          _errorMessage = emailNotValid;
        }
        break;
      case 'auth/user-not-found':
        {
          _errorMessage = userNotFound;
        }
        break;
    }
    showErrorSnackBar(_errorMessage, context);
  } on Exception catch (e) {
    showErrorSnackBar(e.toString(), context);
  }
}

Future<void> verifyEmail(Timer timer, BuildContext context) async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  try {
    await currentUser?.reload();
    if (currentUser!.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacementNamed('/birthdate');
    }
  } on Exception catch (e) {
    showErrorSnackBar(e.toString(), context);
  }
}
