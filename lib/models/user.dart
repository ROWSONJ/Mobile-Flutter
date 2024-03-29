import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String fullName;
  final String email;
  final String phone;
  final String password;

  const UserModel({
    this.uid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
  });

  toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      uid: document.id, // Add this line
      fullName: data['fullName'],
      email: data['email'],
      phone: data['phone'],
      password: data['password'],
    );
  }

}
