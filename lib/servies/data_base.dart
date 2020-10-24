import 'package:flutter/foundation.dart';
import 'package:mo8tarib/app/Screen/property/property_model.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/servies/api_path.dart';
import 'package:mo8tarib/servies/firestore_servies.dart';

abstract class Database {
  Future<void> setUser(User user);
  Stream<User> userStream({@required String userId});
  Future<void> setProperty(Property property);
}

class FireStoreDatabase implements Database {
  FireStoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FireStoreService.instance;

  @override
  Future<void> setUser(User user) async => await _service.setData(
        path: APIPath.users(uid),
        data: user.toMap(),
      );
  @override
  Stream<User> userStream({@required String userId}) => _service.documentStream(
        path: APIPath.users(uid),
        builder: (data, documentId) => User.fromMap(data, documentId),
      );

  String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

  @override
  Future<void> setProperty(Property property) async => await _service.setData(
        path: APIPath.properties(property.pid),
        data: property.toMap(),
      );

//  @override
//  Stream<List<Property>> propertyStream({User user}) =>
//      _service.collectionStream<Property>(
//        path: APIPath.properties(),
//        queryBuilder: user != null
//            ? (query) => query.where('uid', isEqualTo: user.uid)
//            : null,
//        builder: (data, documentID) => Property.fromMap(data, documentID),
//        sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
//      );
}
