import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/appbars.dart';
import '../../constants.dart';
import '../../functions/user_service.dart';
import '../../models/user_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Widget _drawUserTiles() {
    return StreamBuilder(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            UserModel user = UserModel.fromDocument(document);
            String userAge = UserService.calculateAge(user.birthdate).toString();

            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: Image.network(user.pictureUrl!).image,
                    radius: 30,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(user.name! + ','),
                          const SizedBox(width: 5),
                          Text(userAge),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(user.promptMessage!),
                    ],
                  ),
                  Expanded(child: Container()),
                  Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: Image.asset(activityIcons[user.selectedActivity!]).image,
                        backgroundColor: Colors.white,
                      ),
                      Text(user.freeUntil!),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  PreferredSizeWidget _drawAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65),
      child: StreamBuilder(
        stream: users.doc(currentUser!.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return AppBars.photoBar(
                Image.network(snapshot.data!['pictureUrl']), activitySet[snapshot.data!['selectedActivity']], snapshot.data!['freeUntil']);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _drawAppBar(),
      body: _drawUserTiles(),
    );
  }
}
