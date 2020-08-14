import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mo8tarib/model/post.dart';

class post_bloc {
  final _firestore = Firestore.instance;
  var _streamController = StreamController<List<post>>();

  Stream<List<post>> get streampost => _streamController.stream;

  fetchAllPosts() async {
    List<post> _listOfPost = await getposts();
    _streamController.sink.add(_listOfPost);
  }

  Future<List<post>> getposts() async {
    List<post> allpost = [];
    final QuerySnapshot query =
        await _firestore.collection('post').getDocuments();

    if (query.documents.length == 0) {
      return null;
    } else {
      for (DocumentSnapshot q in query.documents) {
        allpost.add(post.fromSnapshot(q));
      }
      print(allpost[0].key);

      return allpost;
    }
  }

  dispose() async {
    _streamController.close();
  }
}
