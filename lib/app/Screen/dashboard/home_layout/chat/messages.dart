import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/home_layout/chat/message_bubble.dart';
import 'package:mo8tarib/app/Screen/dashboard/home_layout/chat/model/chat_model.dart';
import 'package:mo8tarib/app/Screen/dashboard/home_layout/chat/model/chat_room_model.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/app/common_widgets/avatar.dart';
import 'package:mo8tarib/constants/global.dart';
import 'package:mo8tarib/services/data_base.dart';

class Messages extends StatefulWidget {
  final MyUser senderUser;
  final MyUser receiverUser;
  final Database database;
  final String chatId;

  const Messages(
      {Key key, this.senderUser, this.receiverUser, this.database, this.chatId})
      : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final massageTextContrller = TextEditingController();
  String x;
  String idd;
  void add(
      String id, String message, String senderUID, String receiverUID) async {
    if (id == null) {
      id = senderUID + receiverUID;
      setState(() {
        idd = id;
      });

      await FirebaseFirestore.instance
          .collection('mohab_messages')
          .doc(id)
          .collection('chats')
          .add({
        'body': message,
        'senderUID': widget.senderUser.uid,
        'time': DateTime.now().toIso8601String(),
      }).then((value) {
        ChatRoom room = ChatRoom(
            chatId: id, users: [senderUID, receiverUID], lastMessage: value);
        widget.database.addChatRoom(room: room, id: id);
      }).catchError(FlutterError.onError);
    } else {
      FirebaseFirestore.instance
          .collection('mohab_messages')
          .doc(id)
          .collection('chats')
          .add({
        'body': message,
        'senderUID': widget.senderUser.uid,
        'time': DateTime.now().toIso8601String(),
      });
      print(id);
      print('send');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: foregroundColor,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Avatar(photoUrl: widget.receiverUser.photoUrl, radius: 20),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                widget.receiverUser.disPlayName,
                style: TextStyle(color: foregroundColor),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<List<Chat>>(
            stream: widget.database.chatStream(chatID: widget.chatId ?? idd),
            builder: (context, snapshot) {
              print(widget.chatId);
              if (snapshot.hasData) {
                final data = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        itemCount: data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return MassageBubble(
                            ///TODO need to handle user photo
                            //  url: widget.,
                            text: data[index].body,
                            sender: data[index].senderUID,
                            isMe:
                                widget.senderUser.uid == data[index].senderUID,
                          );
                        },
                      ),
                    ),
                    Container(
                      decoration: kMessageContainerDecoration,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: massageTextContrller,
                              decoration: kMessageTextFieldDecoration,
                              onChanged: (value) {
                                setState(() {
                                  x = value;
                                });
                              },
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              massageTextContrller.clear();
                              add(widget.chatId, x, widget.senderUser.uid,
                                  widget.receiverUser.uid);
                              //add();
                            },
                            child: Text(
                              'Send',
                              style: kSendButtonTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                print(snapshot.error.toString() + "111111");
                return Text("error");
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
