import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../functions/user_service.dart';
import 'alerts.dart';

class Authentication {
  //TODO: Change default error messages for production.
  static Future<void> resetUserPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Alerts.showErrorSnackBar(passwordResetSent, context);
    } on FirebaseAuthException catch (e) {
      String _errorMessage;
      switch (e.code) {
        case 'auth/invalid-email':
          _errorMessage = emailNotValid;
          break;
        case 'auth/user-not-found':
          _errorMessage = userNotFound;
          break;
        default:
          _errorMessage = e.code;
          break;
      }
      Alerts.showErrorSnackBar(_errorMessage, context);
    } on Exception catch (e) {
      Alerts.showErrorSnackBar(e.toString(), context);
    }
  }

  static Future<void> signIn(String email, String password, GlobalKey<FormState> formKey, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        User? _currentUser = FirebaseAuth.instance.currentUser;
        if (_currentUser!.emailVerified) {
          UserService.setPresence(true, context);
          Navigator.pushReplacementNamed(context, '/');
        } else {
          Navigator.pushNamed(context, '/verification');
        }
      } on FirebaseAuthException catch (e) {
        String _errorMessage;
        switch (e.code) {
          case 'invalid-email':
            _errorMessage = emailNotValid;
            break;
          case 'user-disabled':
            _errorMessage = userDisabled;
            break;
          case 'user-not-found':
            _errorMessage = userNotFound;
            break;
          case 'wrong-password':
            _errorMessage = wrongPassword;
            break;
          default:
            _errorMessage = e.code;
            break;
        }
        Alerts.showErrorSnackBar(_errorMessage, context);
      } on Exception catch (e) {
        Alerts.showErrorSnackBar(e.toString(), context);
      }
    }
  }

  static Future<void> signOut(BuildContext context) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    try {
      if (currentUser != null) {
        await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({'isOnline': false});
        await FirebaseAuth.instance.signOut();
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        throw Exception('User was null.');
      }
    } on FirebaseException catch (e) {
      String _errorMessage;
      switch (e.code) {
        default:
          _errorMessage = e.code;
          break;
      }
      Alerts.showErrorSnackBar(_errorMessage, context);
    } on Exception catch (e) {
      Alerts.showErrorSnackBar(e.toString(), context);
    }
  }

  static Future<void> signUp(String email, String password, GlobalKey<FormState> formKey, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        UserService.setInitialData(context);
      } on FirebaseAuthException catch (e) {
        String _errorMessage;
        switch (e.code) {
          case 'email-already-in-use':
            _errorMessage = emailAlreadyInUse;
            Navigator.of(context).pushNamed('/login');
            break;
          case 'invalid-email':
            _errorMessage = emailNotValid;
            break;
          case 'weak-password':
            _errorMessage = weakPassword;
            break;
          default:
            _errorMessage = e.code;
            break;
        }
        Alerts.showErrorSnackBar(_errorMessage, context);
      } on Exception catch (e) {
        Alerts.showErrorSnackBar(e.toString(), context);
      }
    }
  }
}
