import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String chatId;
  final List users;
  final CollectionReference chat;

  ChatRoom({this.chat, this.chatId, this.users});

  factory ChatRoom.fromMap(Map<dynamic, dynamic> value, String id) {
    return ChatRoom(
      chatId: id,
      chat: value['chat'],
      users: value['users'],
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chats': chat,
      'users': users,
    };
  }
}
