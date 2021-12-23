import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/constants.dart';
import 'package:connect/functions/user_template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> signIn(String email, String password, GlobalKey<FormState> formKey, context) async {
  if (formKey.currentState!.validate()) {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then(
            (uid) => {
              Navigator.of(context).pushReplacementNamed('/home'),
            },
          );
    } on FirebaseAuthException catch (e) {
      var errorMessage = defaultError;

      if (e.code == 'user-not-found') {
        errorMessage = userNotFound;
      } else if (e.code == 'wrong-password') {
        errorMessage = wrongPassword;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }
}

Future<void> signUp(String email, String password, String name, GlobalKey<FormState> formKey, context) async {
  if (formKey.currentState!.validate()) {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then(
            (uid) => {pushSignUpData(name, context)},
          );
    } on FirebaseAuthException catch (e) {
      var errorMessage = defaultError;

      if (e.code == 'weak-password') {
        errorMessage = passwordStrengthError;
      } else if (e.code == 'email-already-in-use') {
        errorMessage = emailInUseError;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }
}

Future<void> pushSignUpData(String name, context) async {
  User? currentUser = FirebaseAuth.instance.currentUser;

  UserTemplate userTemplate = UserTemplate.signUp();

  userTemplate.email = currentUser!.email;
  userTemplate.uid = currentUser.uid;
  userTemplate.name = name;

  try {
    await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set(userTemplate.toSignUpMap());
    Navigator.of(context).pushReplacementNamed('/home');
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
