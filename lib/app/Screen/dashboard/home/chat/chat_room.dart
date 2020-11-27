import 'package:flutter/material.dart';
import 'package:mo8tarib/app/common_widgets/avatar.dart';
import 'package:mo8tarib/services/data_base.dart';

class ChatRoom extends StatelessWidget {
  final String rec;
  final Database database;

  const ChatRoom({Key key, this.rec, this.database}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: database.userStream(userId: rec),
        builder: (context, snapshot) {
          final userX = snapshot.data;
          return Row(
            children: [
              Avatar(radius: 20, photoUrl: userX.photoUrl),
              Column(
                children: [
                  Text(userX.disPlayName),
                ],
              ),
            ],
          );
        });
  }
}
