import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/video_controller.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videopath;
  const ConfirmScreen(
      {Key? key, required this.videoFile, required this.videopath})
      : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  TextEditingController _songcontroller = TextEditingController();
  TextEditingController _captioncontroller = TextEditingController();
  VideoControllers videoControllers = Get.put(VideoControllers());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(0.8);
    controller.setLooping(true);
  }

  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            child: VideoPlayer(controller),
          ),
          const SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: TextInputField(
                        controller: _songcontroller,
                        icon: Icons.music_note,
                        label: 'Song Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: TextInputField(
                        controller: _captioncontroller,
                        icon: Icons.closed_caption,
                        label: 'Captions'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () => videoControllers.uploadVideo(
                          _songcontroller.text,
                          _captioncontroller.text,
                          widget.videopath),
                      child: Text(
                        'Share',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ))
                ]),
          )
        ],
      )),
    );
  }
}
