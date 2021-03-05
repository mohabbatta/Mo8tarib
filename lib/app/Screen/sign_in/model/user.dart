import 'package:flutter/foundation.dart';
//rename user to myuser bcs firebase change to you user
class MyUser {
  MyUser({
    @required this.uid,
    this.disPlayName = "name",
    this.photoUrl,
    this.age,
    this.address,
    this.email,
    this.gender,
    this.phone,
    this.isNewUser,
  });
  final String uid;
  final String disPlayName;
  final String photoUrl;
  final String age;
  final String address;
  final String email;
  final String gender;
  final String phone;
  final bool isNewUser; //get it from user firebase not stream

  factory MyUser.fromMap(Map<dynamic, dynamic> value, String id) {
    return MyUser(
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
