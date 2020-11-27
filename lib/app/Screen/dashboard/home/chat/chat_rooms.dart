import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/chat/chat_room_model.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/chat/search_users.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/app/common_widgets/avatar.dart';
import 'package:mo8tarib/global.dart';
import 'package:mo8tarib/services/data_base.dart';
import 'package:provider/provider.dart';

class ChatRooms extends StatefulWidget {
  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final database = Provider.of<Database>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SearchUsers(user: user, database: database)));
        },
        child: Icon(Icons.add),
        backgroundColor: foregroundColor,
      ),
      body: StreamBuilder<List<ChatRoom>>(
        stream: database.chatRoomsStream(userID: user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var id =
                    data[index].users.where((element) => element != user.uid);

                return Container(
                  child: Column(
                    children: [
                      Text(id.toString()),
                      Container(
                        child: StreamBuilder<User>(
                          stream: database.userX(
                              userId: "K7oInVEFWEUwWOPGzgwXddjMTaE2"),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final data = snapshot.data;
                              print(data.disPlayName);
                              return Text(data.disPlayName);
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  get() {
    final user =
        User(uid: 'K7oInVEFWEUwWOPGzgwXddjMTaE2', disPlayName: 'ahmed');
    return Row(
      children: [
        Column(
          children: [
            Text(user.disPlayName),
          ],
        ),
      ],
    );
  }
}
