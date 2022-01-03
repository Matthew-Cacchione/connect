import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'alerts.dart';

Future<void> setInterests(List<String> interests, BuildContext context) async {
  User? currentUser = FirebaseAuth.instance.currentUser;

  try {
    if (currentUser != null) {
      await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({'interests': interests});
    } else {
      throw Exception('Database could not return a valid user. User was null');
    }
  } on Exception catch (e) {
    showErrorSnackBar(e.toString(), context);
  }
}

Future<void> setInitialData(String name, BuildContext context) async {
  User? currentUser = FirebaseAuth.instance.currentUser;

  Map<String, dynamic> _userDetails = {'email': currentUser?.email, 'name': name};

  try {
    await FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).set(_userDetails);
    Navigator.of(context).pushNamed('/verification');
  } on Exception catch (e) {
    showErrorSnackBar(e.toString(), context);
  }
}

Future<void> setBirthdate(int birthYear, int birthMonth, int birthDay, BuildContext context) async {
  User? currentUser = FirebaseAuth.instance.currentUser;

  Map<String, int> _userBirthdate = {'year': birthYear, 'month': birthMonth, 'day': birthDay};

  try {
    await FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).update({'birthdate': _userBirthdate});
    Navigator.of(context).pushNamed('/interests');
  } on FirebaseException catch (e) {
    String errorMessage = defaultError;

    switch (e.code) {
      case 'permission-denied':
        {
          errorMessage = permissionDenied;
        }
        break;
    }
    showErrorSnackBar(errorMessage, context);
  } on Exception catch (e) {
    showErrorSnackBar(e.toString(), context);
  }
}
