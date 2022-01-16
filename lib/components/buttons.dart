import 'package:flutter/material.dart';

import '../constants.dart';
import '../functions/authentication.dart';

class Buttons {
  static ButtonStyle getStyle() {
    return ElevatedButton.styleFrom(
      elevation: 5,
      padding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  static TextStyle getTextStyle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  static Widget drawSignOutBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Authentication.signOut(context);
      },
      child: Text(
        signOutBtn.toUpperCase(),
        style: Buttons.getTextStyle(),
      ),
      style: Buttons.getStyle(),
    );
  }
}
