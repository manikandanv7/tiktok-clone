import 'package:cloud_firestore/cloud_firestore.dart';

class Comments {
  String username;
  String comment;
  final datepublished;
  List likes;
  String profilephoto;
  String uid;
  String id;

  Comments(
      {required this.username,
      required this.comment,
      required this.datepublished,
      required this.likes,
      required this.profilephoto,
      required this.uid,
      required this.id});

  Map<String, dynamic> toJson() => {
        'username': username,
        'comment': comment,
        'datepublished': datepublished,
        'likes': likes,
        'profilephoto': profilephoto,
        'uid': uid,
        'id': id,
      };

  static Comments fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comments(
        username: snapshot['username'],
        comment: snapshot['comment'],
        datepublished: snapshot['datepublished'],
        likes: snapshot['likes'],
        profilephoto: snapshot['profilephoto'],
        uid: snapshot['uid'],
        id: snapshot['id']);
  }
}
