import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'alerts.dart';

class UserService {
  static Future<void> setInterests(List<String> interests, BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    try {
      if (currentUser != null) {
        await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({'interests': interests});
      } else {
        throw Exception('Database could not return a valid user. User was null');
      }
    } on Exception catch (e) {
      Alerts.showErrorSnackBar(e.toString(), context);
    }
  }

  static Future<void> setInitialData(String name, BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    Map<String, dynamic> _userDetails = {'email': currentUser?.email, 'name': name};

    try {
      await FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).set(_userDetails);
      Navigator.of(context).pushNamed('/verification');
    } on Exception catch (e) {
      Alerts.showErrorSnackBar(e.toString(), context);
    }
  }

  static Future<void> setBirthdate(int birthYear, int birthMonth, int birthDay, BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    Map<String, int> _userBirthdate = {'year': birthYear, 'month': birthMonth, 'day': birthDay};

    try {
      if (currentUser != null) {
        await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({'birthdate': _userBirthdate});
        Navigator.of(context).pushNamed('/profilepic');
      } else {
        throw Exception('Database could not return a valid user. User was null');
      }
    } on FirebaseException catch (e) {
      String errorMessage = defaultError;

      switch (e.code) {
        case 'permission-denied':
          {
            errorMessage = permissionDenied;
          }
          break;
      }
      Alerts.showErrorSnackBar(errorMessage, context);
    } on Exception catch (e) {
      Alerts.showErrorSnackBar(e.toString(), context);
    }
  }

  static Future<void> setProfilePhoto(File picture, BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    try {
      if (currentUser != null) {
        Reference profileRef = FirebaseStorage.instance.ref(currentUser.uid + '/profilePicture/');
        profileRef.putFile(picture);
        Navigator.of(context).pushReplacementNamed('/interests');
      } else {
        throw Exception('Database could not return a valid user. User was null');
      }
    } on Exception catch (e) {
      Alerts.showErrorSnackBar(e.toString(), context);
    }
  }
}
