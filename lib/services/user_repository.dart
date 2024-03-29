
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/user.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get. find();

  final _db = FirebaseFirestore.instance;

  Future<UserModel> getUserDetails(String email) async {
    final snapshot = await _db.collection("Users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;

  }

  Future<List<UserModel>> allUser() async {
    final snapshot = await _db.collection("Users").get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e))
        .toList();
    return userData;
    }
  }

