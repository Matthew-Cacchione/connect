import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../constants.dart';
import 'firebase_util.dart';

Future<void> setInterestCurrentUser(List<String> interest, BuildContext context) async {
  try {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      FirebaseFirestore.instance.collection("users").doc(currentUser.uid).update({'interests': interest});
    } else {
      throw Exception("Database could not return a valid user. User was null");
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
