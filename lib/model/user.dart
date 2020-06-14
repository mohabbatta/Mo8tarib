//import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final int uid;
  String uPassword;
  final String key;
  //final DocumentReference schoolRef;
  final String imageLink;
  final String name;

  User(this.imageLink, this.name, this.uid, this.uPassword, this.key);
}
