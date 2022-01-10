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

PreferredSizeWidget drawSubtitledAppBar(String title, String subtitle) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(65),
    child: AppBar(
      automaticallyImplyLeading: false,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 5, top: 10),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 0),
            child: Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
