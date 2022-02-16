import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  List<dynamic>? birthdate;
  String? email;
  String freeUntil = "00:00";
  List<dynamic> interests = [];
  bool isOnline = false;
  String name = "none";
  String pictureUrl = "none";
  String promptMessage = "none";
  int selectedActivity = 0;
  int sortPriority = 0;

  UserModel.fromDocument(DocumentSnapshot document) {
    freeUntil = document.get('freeUntil');
    interests = document.get('interests');
    isOnline = document.get('isOnline');
    name = document.get('name');
    pictureUrl = document.get('pictureUrl');
    promptMessage = document.get('promptMessage');
    selectedActivity = document.get('selectedActivity');
  }
}
