import 'package:flutter/foundation.dart';

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
    this.rooms,
    this.bathRooms,
    this.kitchen,
    this.gender,
    this.imageUrls,
  });
  final String uid;
  final String pid;
  final String type;
  final String category;
  final String price;
  final String description;
  final String size;
  final List<String> services;
  final String rooms;
  final String bathRooms;
  final String kitchen;
  final String gender;
  final List<String> imageUrls;

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
      rooms: value['room'],
      bathRooms: value['bathRooms'],
      kitchen: value['kitchen'],
      gender: value['gender'],
      imageUrls: value['imageUrls'],
    );
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
      'rooms': rooms,
      'bathRooms': bathRooms,
      'kitchen': kitchen,
      'gender': gender,
      'imageUrls': imageUrls
    };
  }
}
