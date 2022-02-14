import 'package:flutter/material.dart';

import '../constants.dart';
import '../components/styles.dart';
import '../functions/authentication.dart';

class Buttons {
  static Widget drawSignOutBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Authentication.signOut(context);
      },
      child: Text(
        signOutBtn.toUpperCase(),
        style: Styles.defaultBtnText(),
      ),
      style: Styles.defaultBtn(),
    );
  }
}
