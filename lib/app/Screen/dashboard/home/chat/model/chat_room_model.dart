import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String chatId;
  final List users;
  final DocumentReference lastMessage;
  ChatRoom({this.chatId, this.users, this.lastMessage});

  factory ChatRoom.fromMap(Map<dynamic, dynamic> value, String id) {
    return ChatRoom(
        chatId: id, users: value['users'], lastMessage: value['lastMessage']);
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatID': chatId,
      'users': users,
      'lastMessage': lastMessage,
    };
  }
}
