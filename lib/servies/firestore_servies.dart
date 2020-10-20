import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FireStoreService {
  //private constructor
  FireStoreService._();
  static final instance = FireStoreService._();

  Future<void> setData({
    @required String path,
    @required Map<String, dynamic> data,
  }) async {
    final reference = Firestore.instance.document(path);
    print("$path : $data");
    await reference.setData(data);
  }
}
