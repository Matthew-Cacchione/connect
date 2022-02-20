import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<types.Room>>(
        initialData: const [],
        stream: FirebaseChatCore.instance.rooms(),
        builder: (context, snapshot) {
          List<types.Room>? roomSnapshots = snapshot.data;

          return ListView.builder(
              itemCount: roomSnapshots!.length,
              itemBuilder: (context, index) {
                return Text(roomSnapshots[index].name!);
              });
        },
      ),
    );
  }
}
