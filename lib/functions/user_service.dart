import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'alerts.dart';

class UserService {
  //TODO: Change default error messages for production.
  static Future<void> setInterests(List<String> interests, BuildContext context) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    try {
      if (currentUser != null) {
        await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({'interests': interests});
      } else {
        throw Exception('User was null.');
      }
    } on FirebaseException catch (e) {
      String _errorMessage;
      switch (e.code) {
        case 'permission-denied':
          _errorMessage = permissionDenied;
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

  static Future<void> setInitialData(String name, BuildContext context) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    try {
      if (currentUser != null) {
        final Map<String, dynamic> _userDetails = {
          'email': currentUser.email,
          'name': name,
          'isOnline': false,
          'promptMessage': '',
          'selectedActivity': 0,
          'freeUntil': '00:00',
        };
        await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set(_userDetails);
        Navigator.of(context).pushNamed('/verification');
      } else {
        throw Exception('User was null.');
      }
    } on FirebaseException catch (e) {
      String _errorMessage;
      switch (e.code) {
        case 'permission-denied':
          _errorMessage = permissionDenied;
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

  static Future<void> setBirthdate(DateTime birthdate, BuildContext context) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final userBirthdate = [birthdate.day, birthdate.month, birthdate.year];

    try {
      if (currentUser != null) {
        await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({'birthdate': userBirthdate});
        Navigator.of(context).pushNamed('/profilepic');
      } else {
        throw Exception('User was null.');
      }
    } on FirebaseException catch (e) {
      String _errorMessage;
      switch (e.code) {
        case 'permission-denied':
          _errorMessage = permissionDenied;
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
        throw Exception('User was null.');
      }
    } on FirebaseException catch (e) {
      String _errorMessage;
      switch (e.code) {
        case 'permission-denied':
          _errorMessage = permissionDenied;
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

  static Future<void> activitySelection(int activityIndex, String prompt, DateTime time, BuildContext context) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final String simpleTime = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

    try {
      if (currentUser != null) {
        DocumentReference firestoreRef = FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
        await firestoreRef.update({'selectedActivity': activityIndex, 'freeUntil': simpleTime, 'promptMessage': prompt});
        Navigator.of(context).pushNamed('/navbar');
      } else {
        throw Exception('User was null.');
      }
    } on FirebaseException catch (e) {
      String _errorMessage;
      switch (e.code) {
        case 'not-found':
          _errorMessage = 'No user found.';
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

  static Future<void> setPresence(bool isOnline, BuildContext context) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    try {
      if (currentUser != null) {
        await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({'isOnline': isOnline});
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
}
