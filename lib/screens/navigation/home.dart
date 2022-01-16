import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/appbars.dart';
import '../../functions/user_service.dart';

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
            String userAge = UserService.calculateAge(document.get('birthdate')).toString();

            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: Image.network(document.get('pictureUrl')).image,
                    radius: 30,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(document.get('name') + ','),
                          const SizedBox(width: 5),
                          Text(userAge),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Text('Insert prompt here.'),
                    ],
                  ),
                  Expanded(child: Container()),
                  Column(
                    children: const <Widget>[
                      CircleAvatar(),
                      Text('19:06'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultBar('Home'),
      body: _drawUserTiles(),
    );
  }
}
