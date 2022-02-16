import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/appbars.dart';
import '../../components/styles.dart';
import '../../constants.dart';
import '../../models/user_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void displayProfileDialog(UserModel user) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(
          vertical: 0.1 * MediaQuery.of(context).size.height,
          horizontal: 20,
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.fill, image: Image.network(user.pictureUrl).image),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RichText(
                    text: TextSpan(
                      style: Styles.profileText(),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${user.name} ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: 'is free until ${user.freeUntil}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: Styles.profileText(),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Interests: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${user.interests}'),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Back'.toUpperCase()),
                        style: Styles.profileBtn(),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Chat'.toUpperCase()),
                        style: Styles.profileBtn(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawUserTiles() {
    return StreamBuilder(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        UserModel? currentUserModel;
        List<UserModel> _userModels = [];

        void _setSortPriority(UserModel otherUser) {
          int sortPriority = 0;
          List? commonInterests = currentUserModel!.interests;

          if (otherUser.selectedActivity == currentUserModel.selectedActivity || otherUser.selectedActivity == 5) sortPriority -= 10;

          commonInterests.removeWhere((interest) => !otherUser.interests.contains(interest));
          sortPriority -= commonInterests.length;

          otherUser.sortPriority = sortPriority;
        }

        List<QueryDocumentSnapshot> _userSnapshots = snapshot.data!.docs;
        for (var index = 0; index < _userSnapshots.length; index++) {
          if (_userSnapshots[index].id != currentUser!.uid && _userSnapshots[index].get('isOnline') == true) {
            UserModel userModel = UserModel.fromDocument(_userSnapshots[index]);
            _userModels.add(userModel);
          }

          if (_userSnapshots[index].id == currentUser!.uid) currentUserModel = UserModel.fromDocument(_userSnapshots[index]);
        }

        for (var index = 0; index < _userModels.length; index++) {
          _setSortPriority(_userModels[index]);
        }

        _userModels.sort((firstUser, secondUser) => firstUser.sortPriority.compareTo(secondUser.sortPriority));

        return ListView.builder(
          itemCount: _userModels.length,
          itemBuilder: (context, index) {
            UserModel user = _userModels[index];

            return GestureDetector(
              onTap: () {
                displayProfileDialog(user);
              },
              child: Container(
                decoration: user == _userModels.firstWhere((user) => user.sortPriority > -10)
                    ? const BoxDecoration(border: Border(top: BorderSide(width: 2, color: Colors.black54)))
                    : const BoxDecoration(),
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: Image.network(user.pictureUrl).image,
                      radius: 30,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              user.name + ' is free until ' + user.freeUntil,
                            ),
                            const SizedBox(width: 5),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          user.promptMessage,
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: Image.asset(activityIcons[user.selectedActivity]).image,
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
