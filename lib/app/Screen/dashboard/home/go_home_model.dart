import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/property/property_model.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';

class EntryPost {
  EntryPost(this.property, this.user);

  final Property property;
  final User user;
}

class GoHomeModel {
  final String propertyReference;
  final String userReference;
  final Timestamp time;
  final String id;
  GoHomeModel(
      {@required this.propertyReference,
      @required this.userReference,
      @required this.time,
      @required this.id});

  factory GoHomeModel.fromMap(Map<dynamic, dynamic> value, String id) {
    return GoHomeModel(
      id: id,
      propertyReference: value['flat_id'],
      userReference: value['user_id'],
      time: value['time'],
    );
  }

  Map<dynamic, dynamic> toMap() {
    return <String, dynamic>{
      'flat_id': propertyReference,
      'user_id': userReference,
      'time': time
    };
  }
}
