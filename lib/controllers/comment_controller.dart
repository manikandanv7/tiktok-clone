import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/comments.dart';

class CommentController extends GetxController {
  final Rx<List<Comments>> _comments = Rx<List<Comments>>([]);
  List<Comments> get comments => _comments.value;

  String _postId = "";
  updatePostId(String id) {
    _postId = id;
    getComments();
  }

  getComments() async {
    _comments.bindStream(firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Comments> retvalue = [];
      for (var element in query.docs) {
        retvalue.add(Comments.fromSnap(element));
      }
      return retvalue;
    }));
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userdoc = await firestore
            .collection('users')
            .doc(authcontroller.user.uid)
            .get();
        var alldocs = await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();
        int len = alldocs.docs.length;

        Comments comment = Comments(
            username: (userdoc.data()! as dynamic)['name'],
            comment: commentText.trim(),
            datepublished: DateTime.now(),
            likes: [],
            profilephoto: (userdoc.data()! as dynamic)['profilephoto'],
            uid: authcontroller.user.uid,
            id: 'comment $len');

        await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('comment $len')
            .set(comment.toJson());
        DocumentSnapshot doc =
            await firestore.collection('videos').doc(_postId).get();
        await firestore.collection('videos').doc(_postId).update(
            {'commentscount': (doc.data()! as dynamic)['commentscount'] + 1});
      }
    } catch (e) {
      Get.snackbar('Error while commenting', e.toString());
    }
  }

  likeComment(String id) async {
    var uid = authcontroller.user.uid;
    print(id);
    print(uid);
    DocumentSnapshot doc = await firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();
    print(doc.data().toString());

    if ((doc.data() as dynamic)['likes'].contains(uid)) {
      await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
