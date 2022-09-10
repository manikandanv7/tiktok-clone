import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/videos.dart';
import 'package:video_compress/video_compress.dart';

class VideoControllers extends GetxController {
  //upload video
  Future<String> _uploadImagetoStorage(String id, String videopath) async {
    Reference ref = firestorage.ref().child('Thumbnails').child(id);

    UploadTask uploadtask = ref.putFile(await _getthumbnail(videopath));
    TaskSnapshot snapshot = await uploadtask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  _getthumbnail(String videopath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videopath);
    return thumbnail;
  }

  _compressfile(String video) async {
    final compressedvideo = await VideoCompress.compressVideo(video,
        quality: VideoQuality.MediumQuality);

    return compressedvideo!.file;
  }

  Future<String> _uploadvideotostorage(String id, String videopath) async {
    Reference ref = firestorage.ref().child('videos').child(id);

    UploadTask uploadtask = ref.putFile(await _compressfile(videopath));
    TaskSnapshot snapshot = await uploadtask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadVideo(String songname, String caption, String videopath) async {
    try {
      Get.back();
      String uid = firebaseauth.currentUser!.uid;

      DocumentSnapshot userdoc =
          await firestore.collection('users').doc(uid).get();
      //get id
      var alldocs = await firestore.collection('videos').get();
      int len = alldocs.docs.length;
      String videoUrl = await _uploadvideotostorage("video $len", videopath);
      String thumbnail = await _uploadImagetoStorage("video $len", videopath);
      Video video = Video(
          username: (userdoc.data()! as Map<String, dynamic>)['name'],
          uid: uid,
          id: 'video $len',
          likes: [],
          commentscount: 0,
          sharecounts: 0,
          songname: songname,
          caption: caption,
          videoUrl: videoUrl,
          thumbnail: thumbnail,
          profilephoto:
              (userdoc.data()! as Map<String, dynamic>)['profilephoto']);
      await firestore
          .collection('videos')
          .doc('video $len')
          .set(video.toJson());
    } catch (e) {
      Get.snackbar("Error uploading video", e.toString());
    }
  }
}
