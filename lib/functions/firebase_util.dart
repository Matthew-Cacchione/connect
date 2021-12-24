import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/constants.dart';
import 'package:connect/functions/user_template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Authentication

Future<void> signIn(String email, String password, GlobalKey<FormState> formKey, BuildContext context) async {
  if (formKey.currentState!.validate()) {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacementNamed(context, '/');
    } on FirebaseAuthException catch (e) {
      var errorMessage = defaultError;

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
      pushSignUpData(name, context);
    } on FirebaseAuthException catch (e) {
      var errorMessage = defaultError;

      if (e.code == 'weak-password') {
        errorMessage = passwordStrengthError;
      } else if (e.code == 'email-already-in-use') {
        errorMessage = emailInUseError;
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

void showErrorSnackBar(String errorMessage, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        errorMessage,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}

// Firestore database

Future<void> pushSignUpData(String name, BuildContext context) async {
  User? firebaseUser = FirebaseAuth.instance.currentUser;

  UserTemplate userTemplate = UserTemplate.signUp();

  userTemplate.email = firebaseUser!.email;
  userTemplate.uid = firebaseUser.uid;
  userTemplate.name = name;

  try {
    await FirebaseFirestore.instance.collection('users').doc(userTemplate.uid).set(userTemplate.toSignUpMap());
    Navigator.of(context).pushReplacementNamed('/');
  } on Error {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          defaultError,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
