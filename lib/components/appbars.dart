import 'package:flutter/material.dart';

class AppBars {
  static PreferredSizeWidget defaultBar(String title) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(55),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title),
      ),
    );
  }

  static PreferredSizeWidget photoBar(Image photo, String title) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: photo.image,
              radius: 25,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                const Text(
                  '19:30',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                //TODO: Redirect user to the settings screen.
              },
            ),
          ],
        ),
      ),
    );
  }
}
