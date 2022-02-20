import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  List<dynamic>? birthdate;
  String? email;
  String? firstName;
  String? freeUntil;
  String? imageUrl;
  List<dynamic> interests = [];
  bool? isOnline;
  bool? isSetup;
  String? promptMessage;
  int? selectedActivity;
  int? sortPriority;
  String? uid;

  UserModel({
    this.birthdate,
    this.email,
    this.firstName,
    this.freeUntil,
    this.imageUrl,
    required this.interests,
    this.isOnline,
    this.isSetup,
    this.promptMessage,
    this.selectedActivity,
    this.sortPriority,
    required this.uid,
  });

  UserModel.fromDocument(DocumentSnapshot document) {
    firstName = document.get('firstName');
    freeUntil = document.get('freeUntil');
    imageUrl = document.get('imageUrl');
    interests = document.get('interests');
    isOnline = document.get('isOnline');
    promptMessage = document.get('promptMessage');
    selectedActivity = document.get('selectedActivity');
  }

  Map<String, dynamic> asMap() {
    return {
      'birthdate': birthdate,
      'email': email,
      'firstName': firstName,
      'freeUntil': freeUntil,
      'imageUrl': imageUrl,
      'interests': interests,
      'isOnline': isOnline,
      'isSetup': isSetup,
      'promptMessage': promptMessage,
      'selectedActivity': selectedActivity,
      'sortPriority': sortPriority,
      'uid': uid,
    };
  }
}
