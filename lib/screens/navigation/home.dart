import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/appbars.dart';
import '../../constants.dart';
import '../../globals.dart' as globals;
import '../../models/user_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
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

        List<UserModel> _userModels = [];
        List<QueryDocumentSnapshot> _userSnapshots = snapshot.data!.docs;
        for (var i = 0; i < _userSnapshots.length; i++) {
          if (_userSnapshots[i].id != currentUser!.uid && _userSnapshots[i].get('isOnline') == true) {
            UserModel userModel = UserModel.fromDocument(_userSnapshots[i]);
            _userModels.add(userModel);
          }
        }

        return ListView.builder(
          itemCount: _userModels.length,
          itemBuilder: (context, index) {
            UserModel user = _userModels[index];

            return GestureDetector(
              onTap: () {
                // setState(() {
                //   globals.clickedUsers.add(document.id);
                // });
                //TODO: Display the user's profile.
              },
              child: Container(
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
                            Text(
                              user.name! + ' is free until ' + user.freeUntil!,
                              //style: TextStyle(fontWeight: globals.clickedUsers.contains(document.id) ? FontWeight.w300 : FontWeight.bold),
                            ),
                            const SizedBox(width: 5),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          user.promptMessage!,
                          //style: TextStyle(fontWeight: globals.clickedUsers.contains(document.id) ? FontWeight.w300 : FontWeight.bold),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: Image.asset(activityIcons[user.selectedActivity!]).image,
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
    );
  }

  PreferredSizeWidget _drawAppBar() {
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
                Image.network(snapshot.data!['pictureUrl']), activitySet[snapshot.data!['selectedActivity']], snapshot.data!['freeUntil'], context);
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
