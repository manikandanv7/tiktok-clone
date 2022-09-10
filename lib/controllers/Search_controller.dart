import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/users.dart';

class SearchController extends GetxController {
  final Rx<List<user>> _searchedUsers = Rx<List<user>>([]);
  List<user> get searchedUsers => _searchedUsers.value;
  searchUser(String typeduser) async {
    _searchedUsers.bindStream(firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: typeduser)
        .snapshots()
        .map((QuerySnapshot query) {
      List<user> retval = [];
      for (var element in query.docs) {
        retval.add(user.fromsnap(element));
      }
      return retval;
    }));
  }
}
