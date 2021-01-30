import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/chat/model/chat_model.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/chat/model/chat_room_model.dart';
import 'package:mo8tarib/app/Screen/dashboard/profile/post_model.dart';
import 'package:mo8tarib/app/Screen/property/property_model.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/services/api_path.dart';
import 'package:mo8tarib/services/firestore_servies.dart';

abstract class Database {
  Future<void> setUser(MyUser user);
  Stream<MyUser> userStream({@required String userId});
  Future<void> setProperty(Property property);
  Future<void> addChatRoom({String id, ChatRoom room});
  Stream<List<Property>> propertiesStream({MyUser user});
  Stream<List<MyUser>> usersStream({MyUser user});
  Stream<List<PostModel>> postStream();
  Stream<Property> propertyStream({String propertyId});
  Stream<List<ChatRoom>> chatRoomsStream({String userID});
  Stream<List<ChatRoom>> chatRoom({String one, String two});
  Stream<List<Chat>> chatStream({String chatID});
  Stream<Chat> lastMessage({DocumentReference path});
  Stream<List<PostModel>> postsStream({String userId});
  Future<void> addLike({String postId, String userId});
  Future<void> removeLike({String postId, String userId});
  Stream<List<PostModel>> likePostsStream({String userId});
}

class FireStoreDatabase implements Database {
  FireStoreDatabase({this.uid}) : assert(uid != null);
  final String uid;

  final _service = FireStoreService.instance;

  @override
  Future<void> setUser(MyUser user) async => await _service.setData(
        path: APIPath.users(uid),
        data: user.toMap(),
      );
  @override
  Stream<MyUser> userStream({@required String userId}) => _service.documentStream(
        path: APIPath.users(userId),
        builder: (data, documentId) => MyUser.fromMap(data, documentId),
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
  Stream<List<Property>> propertiesStream({MyUser user}) =>
      _service.collectionStream<Property>(
        path: APIPath.properties(),
        queryBuilder: user != null
            ? (query) => query.where('uid', isEqualTo: user.uid)
            : null,
        builder: (data, documentID) => Property.fromMap(data, documentID),
        // sort: (lhs, rhs) => rhs.startDate.compareTo(lhs.startDate),
      );

  @override
  Stream<List<MyUser>> usersStream({MyUser user}) =>
      _service.collectionStream<MyUser>(
        path: APIPath.usersAll(),
        queryBuilder: user != null
            ? (query) => query.where('uid', isEqualTo: user.uid)
            : null,
        builder: (data, documentID) => MyUser.fromMap(data, documentID),
        // sort: (lhs, rhs) => rhs.startDate.compareTo(lhs.startDate),
      );

  @override
  Stream<List<PostModel>> postStream() => _service.collectionStream<PostModel>(
        path: APIPath.post(),
        builder: (data, documentID) => PostModel.fromMap(data, documentID),
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
  Stream<List<ChatRoom>> chatRoom({String one, String two}) =>
      _service.collectionStream<ChatRoom>(
        path: APIPath.chatRoom(),
        queryBuilder: one != null && two != null
            ? (query) => query.where('users', arrayContains: [two, one])
            : null,
        builder: (data, documentID) => ChatRoom.fromMap(data, documentID),
        // sort: (lhs, rhs) => rhs.startDate.compareTo(lhs.startDate),
      );
  @override
  Stream<List<Chat>> chatStream({String chatID}) =>
      _service.collectionStream<Chat>(
        path: APIPath.chat(chatID),
        builder: (data, documentID) => Chat.fromMap(data),
      );

  @override
  Stream<Chat> lastMessage({DocumentReference path}) =>
      _service.documentReferenceStream(
        path: path,
        builder: (data, documentId) => Chat.fromMap(data),
      );

  @override
  Future<DocumentReference> addChatRoom({String id, ChatRoom room}) async =>
      await _service.setDataSnap(
        path: APIPath.setChatRoom(id),
        data: room.toMap(),
      );

  @override
  Stream<List<PostModel>> postsStream({String userId}) =>
      _service.collectionStream<PostModel>(
        path: APIPath.post(),
        queryBuilder: userId != null
            ? (query) => query.where('user_id', isEqualTo: userId)
            : null,
        builder: (data, documentID) => PostModel.fromMap(data, documentID),
        // sort: (lhs, rhs) => rhs.startDate.compareTo(lhs.startDate),
      );

  @override
  Stream<List<PostModel>> likePostsStream({String userId}) =>
      _service.collectionStream<PostModel>(
        path: APIPath.post(),
        queryBuilder: userId != null
            ? (query) => query.where('likes', arrayContains: userId)
            : null,
        builder: (data, documentID) => PostModel.fromMap(data, documentID),
        // sort: (lhs, rhs) => rhs.startDate.compareTo(lhs.startDate),
      );

  @override
  Future<void> addLike({String postId, String userId}) async {
    await FirebaseFirestore.instance
        .collection('mohab_posts')
        .doc(postId)
        .update({
      "likes": FieldValue.arrayUnion([userId])
    });
  }

  @override
  Future<void> removeLike({String postId, String userId}) async {
    await FirebaseFirestore.instance
        .collection('mohab_posts')
        .doc(postId)
        .update({
      "likes": FieldValue.arrayRemove([userId])
    });
  }
}
