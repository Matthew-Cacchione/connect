import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:intl/intl.dart';

import '../../components/appbars.dart';
import '../../components/styles.dart';
import '../../constants.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  PreferredSizeWidget drawAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: StreamBuilder(
        stream: users.doc(currentUser!.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return AppBars.photoBar(
                Image.network(snapshot.data!['imageUrl']), activitySet[snapshot.data!['selectedActivity']], snapshot.data!['freeUntil'], context);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: drawAppBar(),
      body: StreamBuilder<List<types.Room>>(
        initialData: const [],
        stream: FirebaseChatCore.instance.rooms(),
        builder: (context, snapshot) {
          List<types.Room>? roomSnapshots = snapshot.data;

          return ListView.builder(
            itemCount: roomSnapshots!.length,
            itemBuilder: (context, index) {
              types.Room room = roomSnapshots[index];

              Widget lastMessage() {
                if (room.lastMessages != null) {
                  return Text(room.lastMessages![0].toString());
                } else {
                  return const Text("No messages sent.");
                }
              }

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
                        backgroundImage: Image.network(room.imageUrl!).image,
                        radius: 30,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            room.name!,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          lastMessage(),
                        ],
                      ),
                      Expanded(child: Container()),
                      Column(
                        children: <Widget>[
                          const CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 16,
                          ),
                          const SizedBox(height: 5),
                          Text(DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(room.updatedAt!))),
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
