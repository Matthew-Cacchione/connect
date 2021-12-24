import 'package:connect/constants.dart';
import 'package:connect/functions/firebase_util.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  Widget drawSignOutBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        signOut(context);
      },
      child: Text(
        signOutBtn.toUpperCase(),
        style: const TextStyle(
          color: colorSecondary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: colorPrimary,
        elevation: 5,
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text(profileTitle),
      ),
      backgroundColor: colorSecondary,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: colorSecondary,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                    height: 200,
                  ),
                  const SizedBox(height: 50),
                  drawSignOutBtn(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
