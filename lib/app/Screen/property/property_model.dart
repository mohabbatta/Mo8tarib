import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class Property {
  Property({
    @required this.uid,
    @required this.pid,
    this.type,
    this.category,
    this.price,
    this.description,
    this.size,
    this.services,
    this.gender,
    this.imageUrls,
    this.endDate,
    this.startDate,
    this.address,
    this.position,
  });
  final String uid;
  final String pid;
  final String type;
  final String category;
  final String gender;
  final String description;
  final String size;
  final int price;
  final String address;
  final GeoPoint position;
  final String startDate;
  final String endDate;
  final List services;
  final List imageUrls;

  factory Property.fromMap(Map<dynamic, dynamic> value, String id) {
    return Property(
        pid: id,
        uid: value['uid'],
        type: value['type'],
        category: value['category'],
        price: value['price'],
        description: value['description'],
        size: value['size'],
        services: value['services'],
        gender: value['gender'],
        imageUrls: value['imageUrls'],
        endDate: value['endDate'],
        startDate: value['startDate'],
        address: value['address'],
        position: value['position']);
  }

  Map<dynamic, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'type': type,
      'category': category,
      'price': price,
      'description': description,
      'size': size,
      'services': services,
      'gender': gender,
      'imageUrls': imageUrls,
      'startDate': startDate,
      'endDate': endDate,
      'address': address,
      'position': position,
    };
  }
}
