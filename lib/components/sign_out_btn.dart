import 'package:connect/constants.dart';
import 'package:connect/functions/firebase_util.dart';
import 'package:flutter/material.dart';

Widget drawSignOutBtn(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      signOut(context);
    },
    child: Text(
      signOutBtn.toUpperCase(),
      style: const TextStyle(
        color: colorSecondary,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    style: ElevatedButton.styleFrom(
      primary: colorPrimary,
      elevation: 5,
      padding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}
