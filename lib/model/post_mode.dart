import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  DocumentReference user;
  Timestamp time;
  DocumentReference flat;
  PostModel(this.user, this.flat, this.time);
}

final List<PostModel> postList = [];
