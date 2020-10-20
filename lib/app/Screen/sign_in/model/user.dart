import 'package:flutter/foundation.dart';

class User {
  User({
    @required this.uid,
    this.displayName,
    this.photoUrl,
    this.firstName,
    this.midName,
    this.lastName,
    this.age,
    this.address,
    this.email,
    this.gender,
    this.phone,
    this.url,
  });
  final String uid;
  final String displayName;
  final String photoUrl;
  final String firstName;
  final String midName;
  final String lastName;
  final String age;
  final String address;
  final String email;
  final String gender;
  final String phone;
  final String url;

  factory User.fromMap(Map<dynamic, dynamic> value, String id) {
    return User(
      uid: id,
      firstName: value['name']['first'],
      midName: value['name']['mid'],
      lastName: value['name']['last'],
      age: value['age'],
      address: value['address'],
      email: value['email'],
      gender: value['gender'],
      phone: value['phone'],
      url: value['url'],
    );
  }

  Map<dynamic, dynamic> toMap() {
    return <String, dynamic>{
      'name': {
        'first': firstName,
        'mid': midName,
        'last': lastName,
      },
      'age': age,
      'email': email,
      'phone': phone,
      'gender': gender,
      'url': url,
      'address': address,
    };
  }
}
