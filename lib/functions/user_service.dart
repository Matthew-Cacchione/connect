import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'alerts.dart';

Future<void> setInterests(List<String> interest, BuildContext context) async {
  User? currentUser = FirebaseAuth.instance.currentUser;

  try {
    if (currentUser != null) {
      FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({'interests': interest});
    } else {
      throw Exception('Database could not return a valid user. User was null');
    }
  } on FirebaseAuthException catch (e) {
    var errorMessage = defaultError;

    if (e.code == 'user-not-found') {
      errorMessage = userNotFound;
    } else if (e.code == 'wrong-password') {
      errorMessage = wrongPassword;
    }
    showErrorSnackBar(errorMessage, context);
  } on Exception catch (e) {
    showErrorSnackBar(e.toString(), context);
  }
}

Future<void> setInitialData(String name, BuildContext context) async {
  User? currentUser = FirebaseAuth.instance.currentUser;

  Map<String, dynamic> _userDetails = {'uid': currentUser!.uid, 'email': currentUser.email, 'name': name};

  try {
    await FirebaseFirestore.instance.collection('users').doc(_userDetails['uid']).set(_userDetails);
    Navigator.of(context).pushNamed('/verification');
  } on Error {
    showErrorSnackBar(defaultError, context);
  }
}
