import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/chat/messages.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/app/common_widgets/avatar.dart';
import 'package:mo8tarib/global.dart';

class ChatBubble extends StatelessWidget {
  final User senderUser;
  final User receiverUser;

  const ChatBubble({Key key, this.senderUser, this.receiverUser})
      : super(key: key);
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => (Messages(
                    senderUser: senderUser, receiverUser: receiverUser))));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: EdgeInsets.all(8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Avatar(photoUrl: receiverUser.photoUrl, radius: 20),
                  SizedBox(width: size.width * .03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${receiverUser.disPlayName}',
                          style: TextStyle(
                              color: color1,
                              fontSize: 24,
                              fontStyle: FontStyle.italic)),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
