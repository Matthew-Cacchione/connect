import 'package:flutter/material.dart';

import '../../components/appbars.dart';
import '../../components/buttons.dart';
import '../../constants.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultBar(chatTitle),
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
                Buttons.drawSignOutBtn(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
