import 'package:flutter/foundation.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/chat/chat_room_model.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/go_home_model.dart';
import 'package:mo8tarib/app/Screen/property/property_model.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/services/api_path.dart';
import 'package:mo8tarib/services/firestore_servies.dart';

abstract class Database {
  Future<void> setUser(User user);
  Stream<User> userStream({@required String userId});
  Future<void> setProperty(Property property);
  Stream<List<Property>> propertiesStream({User user});
  Stream<List<User>> usersStream({User user});
  Stream<List<GoHomeModel>> postStream();
  Stream<Property> propertyStream({String propertyId});
  Stream<List<ChatRoom>> chatRoomsStream({String userID});
  Stream<User> userX({@required String userId});
}

class FireStoreDatabase implements Database {
  FireStoreDatabase({this.uid}) : assert(uid != null);
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

  @override
  Stream<Property> propertyStream({@required String propertyId}) =>
      _service.documentStream(
        path: APIPath.property(propertyId),
        builder: (data, documentId) => Property.fromMap(data, documentId),
      );

  String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

  @override
  Future<void> setProperty(Property property) async => await _service.setData(
        path: APIPath.property(property.pid),
        data: property.toMap(),
      );

  @override
  Stream<List<Property>> propertiesStream({User user}) =>
      _service.collectionStream<Property>(
        path: APIPath.properties(),
        queryBuilder: user != null
            ? (query) => query.where('uid', isEqualTo: user.uid)
            : null,
        builder: (data, documentID) => Property.fromMap(data, documentID),
        // sort: (lhs, rhs) => rhs.startDate.compareTo(lhs.startDate),
      );

  @override
  Stream<List<User>> usersStream({User user}) =>
      _service.collectionStream<User>(
        path: APIPath.usersAll(),
        queryBuilder: user != null
            ? (query) => query.where('uid', isEqualTo: user.uid)
            : null,
        builder: (data, documentID) => User.fromMap(data, documentID),
        // sort: (lhs, rhs) => rhs.startDate.compareTo(lhs.startDate),
      );

  @override
  Stream<List<GoHomeModel>> postStream() =>
      _service.collectionStream<GoHomeModel>(
        path: APIPath.post(),
        builder: (data, documentID) => GoHomeModel.fromMap(data, documentID),
        // sort: (lhs, rhs) => rhs.startDate.compareTo(lhs.startDate),
      );

  @override
  Stream<List<ChatRoom>> chatRoomsStream({String userID}) =>
      _service.collectionStream<ChatRoom>(
        path: APIPath.chatRoom(),
        queryBuilder: userID != null
            ? (query) => query.where('users', arrayContains: userID)
            : null,
        builder: (data, documentID) => ChatRoom.fromMap(data, documentID),
        // sort: (lhs, rhs) => rhs.startDate.compareTo(lhs.startDate),
      );

  @override
  Stream<User> userX({String userId}) => _service.documentStream(
        path: APIPath.users(uid),
        builder: (data, documentId) => User.fromMap(data, documentId),
      );
}
