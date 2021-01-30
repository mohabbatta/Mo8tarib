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
    final reference = FirebaseFirestore.instance.doc(path);
    print("$path : $data");
    await reference.set(data);
  }

  Future<DocumentReference> setDataSnap({
    @required String path,
    @required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore .instance.doc(path);
    print("$path : $data");
    await reference.set(data);
    return reference;
  }

  Stream<T> documentStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentID),
  }) {
    final DocumentReference reference = FirebaseFirestore .instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots
        .map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  Stream<T> documentReferenceStream<T>({
    @required DocumentReference path,
    @required T builder(Map<String, dynamic> data, String documentID),
  }) {
    final DocumentReference reference = path;
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots
        .map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  Stream<T> docStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentID),
  }) {
    final DocumentReference reference = FirebaseFirestore .instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots
        .map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentID),
    Query queryBuilder(Query query),
    int sort(T lhs, T rhs),
  }) {
    Query query = FirebaseFirestore .instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    try {
      final Stream<QuerySnapshot> snapshots = query.snapshots();
      return snapshots.map((snapshot) {
        final result = snapshot.docs
            .map((snapshot) => builder(snapshot.data(), snapshot.id))
            .where((value) => value != null)
            .toList();
//        if (sort != null) {
//          result.sort(sort);
//        }
        return result;
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
