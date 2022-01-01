import 'package:flutter/material.dart';

import '../constants.dart';
import '../functions/firebase_util.dart';

Widget drawSignOutBtn(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      signOut(context);
    },
    child: Text(
      signOutBtn.toUpperCase(),
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    style: ElevatedButton.styleFrom(
      elevation: 5,
      padding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}
