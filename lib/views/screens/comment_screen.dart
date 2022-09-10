import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({Key? key, required this.id}) : super(key: key);
  final TextEditingController _commentcontroller = TextEditingController();
  CommentController commentcontroller = Get.put(CommentController());
  @override
  Widget build(BuildContext context) {
    commentcontroller.updatePostId(id);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                      itemCount: commentcontroller.comments.length,
                      itemBuilder: ((context, index) {
                        final comment = commentcontroller.comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(comment.profilephoto),
                          ),
                          title: Row(
                            children: [
                              Text(
                                comment.username,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Colors.red),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                comment.comment,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Colors.white),
                              )
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                tago.format(comment.datepublished.toDate()),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${comment.likes.length} likes',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              )
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () =>
                                commentcontroller.likeComment(comment.id),
                            child: Icon(
                              Icons.favorite,
                              size: 25,
                              color: comment.likes
                                      .contains(authcontroller.user.uid)
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ),
                        );
                      }));
                }),
              ),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: _commentcontroller,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  decoration: const InputDecoration(
                      labelText: 'comment',
                      labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))),
                ),
                trailing: TextButton(
                    onPressed: () =>
                        commentcontroller.postComment(_commentcontroller.text),
                    child: Text(
                      'send',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
