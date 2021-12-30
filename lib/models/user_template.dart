class UserTemplate {
  String? uid;
  String? email;
  String? name;

  UserTemplate({required this.uid, this.email, this.name});

  Map<String, dynamic> toSignUpMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }
}
