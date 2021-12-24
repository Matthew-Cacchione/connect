import 'package:connect/constants.dart';
import 'package:connect/functions/authentication.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text(homeTitle),
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
                  ElevatedButton(
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
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
