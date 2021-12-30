import 'package:flutter/material.dart';

import '../constants.dart';

PreferredSizeWidget drawAppBar(String title) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(55),
    child: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: colorPrimary,
      title: Text(title),
    ),
  );
}
