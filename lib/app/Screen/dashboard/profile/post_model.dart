import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String postId;
  final String flatId;
  final String userId;
  final List likes;
  final Timestamp time;

  PostModel({this.flatId, this.userId, this.time, this.postId, this.likes});
  factory PostModel.fromMap(Map<dynamic, dynamic> value, String documentId) {
    return PostModel(
      postId: documentId,
      flatId: value['flat_id'],
      userId: value['user_id'],
      likes: value['likes'],
      time: value['time'],
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'flat_id': flatId,
      'user_id': userId,
      'time': time,
      'likes': likes
    };
  }
}
