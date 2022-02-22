import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

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
      body: StreamBuilder<List<types.Room>>(
        initialData: const [],
        stream: FirebaseChatCore.instance.rooms(),
        builder: (context, snapshot) {
          List<types.Room>? roomSnapshots = snapshot.data;

          return ListView.builder(
            itemCount: roomSnapshots!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  //TODO: Open chat with the user that was clicked on.
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: Image.network(roomSnapshots[index].imageUrl!).image,
                        radius: 30,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(roomSnapshots[index].name!),
                          const SizedBox(height: 5),
                          //Text(roomSnapshots[index].lastMessages![0].toString()),
                        ],
                      ),
                      Expanded(child: Container()),
                      Column(
                        children: const <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
