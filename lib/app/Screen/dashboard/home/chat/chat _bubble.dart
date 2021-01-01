import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/chat/messages.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/chat/model/chat_model.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/app/common_widgets/avatar.dart';
import 'package:mo8tarib/services/data_base.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key key,
    this.chatId,
    this.lastMessage,
    @required this.senderUser,
    @required this.receiverUser,
    @required this.database,
  }) : super(key: key);

  final String chatId;
  final User senderUser;
  final User receiverUser;
  final Database database;
  final DocumentReference lastMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => (Messages(
                        chatId: chatId ?? senderUser.uid + receiverUser.uid,
                        senderUser: senderUser,
                        receiverUser: receiverUser,
                        database: database,
                      ))));
        },
        child: StreamBuilder<Chat>(
            stream: database.lastMessage(path: lastMessage),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final lastMessage = snapshot.data;
                return Container(
                  height: 60,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Avatar(photoUrl: receiverUser.photoUrl, radius: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            receiverUser.disPlayName,
                            style: TextStyle(fontSize: 24),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              lastMessage.body,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        Jiffy(lastMessage.time).fromNow(),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
