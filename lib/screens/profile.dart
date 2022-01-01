import 'package:connect/components/appbar.dart';
import 'package:connect/components/sign_out_btn.dart';
import 'package:connect/constants.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: drawAppBar(profileTitle),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
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
    );
  }
}
