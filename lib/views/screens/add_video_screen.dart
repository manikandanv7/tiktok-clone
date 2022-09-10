import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/confirmScreen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  pickVideofile(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ConfirmScreen(
                videoFile: File(video.path),
                videopath: video.path,
              )));
    }
  }

  showoptionsDialog(context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () => pickVideofile(ImageSource.gallery, context),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      children: const [
                        Icon(Icons.image),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Gallery',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => pickVideofile(ImageSource.camera, context),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      children: const [
                        Icon(Icons.camera_alt),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Camera',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      children: const [
                        Icon(Icons.cancel_outlined),
                        Padding(
                          padding: EdgeInsets.all(7.0),
                          child: Text(
                            'Cancel',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: InkWell(
        onTap: () => showoptionsDialog(context),
        child: Container(
          width: 190,
          height: 50,
          decoration: BoxDecoration(color: buttonColor),
          child: Center(
            child: Text(
              'Add a video',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
          ),
        ),
      )),
    );
  }
}
