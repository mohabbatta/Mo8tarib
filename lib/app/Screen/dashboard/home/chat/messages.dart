import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/chat/chat_room_model.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/global.dart';

class Messages extends StatefulWidget {
  final User senderUser;
  final User receiverUser;

  const Messages({Key key, this.senderUser, this.receiverUser})
      : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final massageTextContrller = TextEditingController();
  String massageText;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  void add() {
    var id = widget.senderUser.uid + widget.senderUser.uid;

    Firestore.instance.collection('mohab_messages').document(id).setData({
      'id': id,
      'users': [widget.senderUser.uid, widget.receiverUser.uid],
    });

    Firestore.instance
        .collection('mohab_messages')
        .document(id)
        .collection('chats')
        .add({
      'body': massageTextContrller.text,
      'sender': widget.senderUser.uid,
      'time': DateTime.now().toIso8601String(),
    });
    print(id);
    print('send');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          widget.receiverUser.disPlayName,
          style: TextStyle(
            color: foregroundColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MassagesStream(),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: massageTextContrller,
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        massageTextContrller.clear();
                        add();
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String add(String s1, String s2) {
  List<int> a = [];
  int sum = 0;
  for (int i = 0; i < s1.length; i++) {
    sum = (s1.codeUnitAt(i) + s2.codeUnitAt(i)) % 97;
    a.add(sum);
  }
  print(a);
  print(new String.fromCharCodes(a));
  return new String.fromCharCodes(a);
}

int i;

class MassagesStream extends StatelessWidget {
  //String users =add(id,rece);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
//      stream: _firestore.collection('massages')
//           .where("users",isEqualTo: users).orderBy('time')
//          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // print([id , rece]);
          print('no data');
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final massages = snapshot.data.documents.reversed;
        List<MassageBubble> massageWidgets = [];
        i = massages.toList().length;
        int x = 0;
        for (var massage in massages) {
          print("iiiiiiiiiiiii$i");
          print('tata1');
          // final Map massageText=massage.data['text$x'];
          //  final massageSender=massage.data['sender'];
          // final currentUser=loggedInUser.email;
          final massageWidget = MassageBubble(
            text: massage.data['text'],
            sender: massage.data['sender'],
            // isMe: loggedInUser.email==massage.data['sender'],
          );
          massageWidgets.add(massageWidget);
          x++;
        }
        return Expanded(
          child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: massageWidgets),
        );
      },
    );
  }
}

class MassageBubble extends StatelessWidget {
  MassageBubble({this.text, this.sender, this.isMe = false});

  final String text;
  final String sender;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    print('tata');
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(fontSize: 12.0, color: color2),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: isMe ? color2 : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.lightBlueAccent,
                    fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
