import 'package:flutter/material.dart';

PreferredSizeWidget drawAppBar(String title) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(55),
    child: AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
    ),
  );
}
