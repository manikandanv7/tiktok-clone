import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/users.dart' as model;
import 'package:tiktok_clone/views/screens/auth/home_screen.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';

class Authcontroller extends GetxController {
  late Rx<File?> _pickedimage;
  late Rx<User?> _user;

  static Authcontroller instance = Get.find();
  File? get profilephoto => _pickedimage.value;
  User get user => _user.value!;
  void pickimage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile picture', 'Profile Picture uploaded successfully');
    }
    _pickedimage = Rx<File?>(File(pickedImage!.path));
  }

  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseauth.currentUser);
    _user.bindStream(firebaseauth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else
      Get.offAll(() => HomeScreen());
  }

  //uploading the profile pic in storage
  Future<String> _uploadtoStorage(File Image) async {
    Reference ref = firestorage
        .ref()
        .child('profilepics')
        .child(firebaseauth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(Image);
    TaskSnapshot snap = await uploadTask;
    String downloadurl = await snap.ref.getDownloadURL();
    return downloadurl;
  }

  void registeruser(
      String username, String email, String password, File? image) async {
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          image != null) {
        //save our user to the firebase
        UserCredential cred = await firebaseauth.createUserWithEmailAndPassword(
            email: email, password: password);

        String url = await _uploadtoStorage(image);
        model.user user1 = model.user(
            name: username,
            email: email,
            profilephoto: url,
            uid: cred.user!.uid);
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user1.toJson());
      } else {
        Get.snackbar('Error in creating the account', 'Fill all the fields');
      }
    } catch (e) {
      Get.snackbar('Error in creating the account', e.toString());
    }
  }

  void login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseauth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar(
            'Error in creating the account', 'Register to Create an account');
      }
    } catch (e) {
      Get.snackbar('Invalid user', e.toString());
    }
  }

  void signout() async {
    await firebaseauth.signOut();
  }
}
