import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme(
    primary: colorPrimary,
    primaryVariant: colorPrimary,
    secondary: colorSecondary,
    secondaryVariant: colorSecondary,
    surface: Colors.white,
    background: Colors.white,
    error: colorError,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.black,
    brightness: Brightness.light,
  ),
);
