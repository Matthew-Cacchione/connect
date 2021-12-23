class UserTemplate {
  String? uid;
  String? email;
  String? name;

  UserTemplate.signUp({this.uid, this.email, this.name});

  factory UserTemplate.fromSignUpMap(userMap) {
    return UserTemplate.signUp();
  }

  Map<String, dynamic> toSignUpMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }
}
