import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  List<dynamic>? birthdate;
  String? email;
  String? freeUntil;
  List<dynamic>? interests;
  String? name;
  String? pictureUrl;
  String? promptMessage;
  int? selectedActivity;
  bool isOnline = false;
  int sortPriority = 0;

  UserModel.fromDocument(DocumentSnapshot document) {
    birthdate = document.get('birthdate');
    email = document.get('email');
    freeUntil = document.get('freeUntil');
    interests = document.get('interests');
    name = document.get('name');
    pictureUrl = document.get('pictureUrl');
    promptMessage = document.get('promptMessage');
    selectedActivity = document.get('selectedActivity');
    isOnline = document.get('isOnline');
  }
}
