import 'package:cloud_firestore/cloud_firestore.dart';

class user {
  String name;
  String email;
  String profilephoto;
  String uid;
  user(
      {required this.name,
      required this.email,
      required this.profilephoto,
      required this.uid});

  Map<String, dynamic> toJson() =>
      {'name': name, 'email': email, 'profilephoto': profilephoto, 'uid': uid};

  static user fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return user(
        name: snapshot['name'],
        email: snapshot['email'],
        profilephoto: snapshot['profilephoto'],
        uid: snapshot['uid']);
  }
}
