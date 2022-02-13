import 'package:connect/constants.dart';
import 'package:flutter/material.dart';

class Styles {
  static TextStyle anchorTxt() {
    return const TextStyle(
      color: colorPrimary,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle defaultBtnTxt() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  static ButtonStyle defaultBtn() {
    return ElevatedButton.styleFrom(
      elevation: 1,
      padding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  static InputDecoration defaultTxtField(String label, Icon icon) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.all(15),
      labelText: label,
      prefixIcon: icon,
    );
  }

  static TextStyle dialogTitle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle dialogTxt() {
    return TextStyle(
      color: Colors.grey[800],
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle profileTxt() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 18,
    );
  }

  static ButtonStyle profileBtn() {
    return ElevatedButton.styleFrom(
      elevation: 0,
      padding: const EdgeInsets.all(20),
    );
  }
}
