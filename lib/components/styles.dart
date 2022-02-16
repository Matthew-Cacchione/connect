import 'package:flutter/material.dart';

import '../constants.dart';

class Styles {
  static TextStyle anchorText() {
    return const TextStyle(
      color: colorPrimary,
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

  static TextStyle defaultBtnText() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  static InputDecoration defaultTextField(String label, Icon icon) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.all(15),
      labelText: label,
      prefixIcon: icon,
    );
  }

  static TextStyle dialogText() {
    return TextStyle(
      color: Colors.grey[800],
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle dialogTitle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  static ButtonStyle profileBtn() {
    return ElevatedButton.styleFrom(
      elevation: 0,
      padding: const EdgeInsets.all(20),
    );
  }

  static TextStyle profileText() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 18,
    );
  }
}
