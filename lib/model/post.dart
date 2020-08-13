import 'package:cloud_firestore/cloud_firestore.dart';
class post{
  String key;
  DocumentReference user;
  Timestamp time;
  DocumentReference flat;
  post({this.key, this.user, this.time,this.flat});
  factory post.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data;
    return post(
        key: snapshot.documentID,
        user: data['user_id'],
        time :data['time'],
        flat:data['flat_id']);
  }
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['flat_id'] = this.flat;
    data['time'] = this.time;
    data['user_id'] = this.user;

    return data;
  }}