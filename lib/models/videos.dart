import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String uid;
  String id;
  List likes;
  int commentscount;
  int sharecounts;
  String songname;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilephoto;

  Video(
      {required this.username,
      required this.uid,
      required this.id,
      required this.likes,
      required this.commentscount,
      required this.sharecounts,
      required this.songname,
      required this.caption,
      required this.videoUrl,
      required this.thumbnail,
      required this.profilephoto});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "id": id,
        "likes": likes,
        "commentscount": commentscount,
        "sharecounts": sharecounts,
        "songname": songname,
        "caption": caption,
        "videoUrl": videoUrl,
        "thumbnail": thumbnail,
        "profilephoto": profilephoto
      };

  static Video fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
        username: snapshot['username'],
        uid: snapshot['uid'],
        id: snapshot['id'],
        likes: snapshot['likes'],
        commentscount: snapshot['commentscount'],
        sharecounts: snapshot['sharecounts'],
        songname: snapshot['songname'],
        caption: snapshot['caption'],
        videoUrl: snapshot['videoUrl'],
        thumbnail: snapshot['thumbnail'],
        profilephoto: snapshot['profilephoto']);
  }
}
