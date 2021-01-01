import 'package:flutter/foundation.dart';

class User {
  User({
    @required this.uid,
    this.disPlayName = "name",
    this.photoUrl,
    this.age,
    this.address,
    this.email,
    this.gender,
    this.phone,
  });
  final String uid;
  final String disPlayName;
  final String photoUrl;
  final String age;
  final String address;
  final String email;
  final String gender;
  final String phone;

  factory User.fromMap(Map<dynamic, dynamic> value, String id) {
    return User(
        uid: id,
        disPlayName: value['disPlayName'],
        age: value['age'],
        address: value['address'],
        email: value['email'],
        gender: value['gender'],
        phone: value['phone'],
        photoUrl: value['photoUrl']);
  }

  Map<dynamic, dynamic> toMap() {
    return <String, dynamic>{
      'disPlayName': disPlayName,
      'age': age,
      'email': email,
      'phone': phone,
      'gender': gender,
      'photoUrl': photoUrl,
      'address': address,
    };
  }
}
