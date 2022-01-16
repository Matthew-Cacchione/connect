import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'alerts.dart';

class UserService {
  static Future<void> setInterests(List<String> interests, BuildContext context) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    try {
      if (currentUser != null) {
        await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({'interests': interests});
      } else {
        throw Exception('User was null');
      }
    } on FirebaseException catch (e) {
      String _errorMessage;
      switch (e.code) {
        case 'permission-denied':
          {
            _errorMessage = permissionDenied;
          }
          break;
        default:
          {
            _errorMessage = defaultError;
          }
          break;
      }
      Alerts.showErrorSnackBar(_errorMessage, context);
    } on Exception catch (e) {
      Alerts.showErrorSnackBar(e.toString(), context);
    }
  }

  static Future<void> setInitialData(String name, BuildContext context) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    try {
      if (currentUser != null) {
        final Map<String, dynamic> _userDetails = {'email': currentUser.email, 'name': name};
        await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set(_userDetails);
        Navigator.of(context).pushNamed('/verification');
      } else {
        throw Exception('User was null.');
      }
    } on FirebaseException catch (e) {
      String _errorMessage;
      switch (e.code) {
        case 'permission-denied':
          {
            _errorMessage = permissionDenied;
          }
          break;
        default:
          {
            _errorMessage = defaultError;
          }
          break;
      }
      Alerts.showErrorSnackBar(_errorMessage, context);
    } on Exception catch (e) {
      Alerts.showErrorSnackBar(e.toString(), context);
    }
  }

  static Future<void> setBirthdate(DateTime birthdate, BuildContext context) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final userBirthdate = [birthdate.day, birthdate.month, birthdate.year];

    try {
      if (currentUser != null) {
        await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({'birthdate': userBirthdate});
        Navigator.of(context).pushNamed('/profilepic');
      } else {
        throw Exception('User was null');
      }
    } on FirebaseException catch (e) {
      String _errorMessage;
      switch (e.code) {
        case 'permission-denied':
          {
            _errorMessage = permissionDenied;
          }
          break;
        default:
          {
            _errorMessage = defaultError;
          }
          break;
      }
      Alerts.showErrorSnackBar(_errorMessage, context);
    } on Exception catch (e) {
      Alerts.showErrorSnackBar(e.toString(), context);
    }
  }

  static Future<void> setProfilePhoto(File picture, BuildContext context) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    try {
      if (currentUser != null) {
        Reference profileRef = FirebaseStorage.instance.ref(currentUser.uid + '/profilePicture/');
        await profileRef.putFile(picture);

        String pictureUrl = await profileRef.getDownloadURL();
        await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({'pictureUrl': pictureUrl});
        Navigator.of(context).pushReplacementNamed('/interests');
      } else {
        throw Exception('User was null');
      }
    } on FirebaseException catch (e) {
      String _errorMessage;
      switch (e.code) {
        case 'permission-denied':
          {
            _errorMessage = permissionDenied;
          }
          break;
        default:
          {
            _errorMessage = e.message.toString();
          }
          break;
      }
      Alerts.showErrorSnackBar(_errorMessage, context);
    } on Exception catch (e) {
      Alerts.showErrorSnackBar(e.toString(), context);
    }
  }

  static int calculateAge(birthdate) {
    DateTime currentDate = DateTime.now();
    int age = (currentDate.year - birthdate[2]).toInt();

    int currentMonth = currentDate.month;
    int birthMonth = birthdate[1];
    if (birthMonth > currentMonth) {
      age--;
    } else if (birthMonth == currentMonth) {
      int currentDay = currentDate.day;
      int birthDay = birthdate[0];
      if (birthDay > currentDay) {
        age--;
      }
    }
    return age;
  }
}
