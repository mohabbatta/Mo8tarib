import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/chat/chat%20_bubble.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/chat/model/chat_room_model.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/chat/search_users.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/global.dart';
import 'package:mo8tarib/services/data_base.dart';
import 'package:provider/provider.dart';

class ChatRooms extends StatefulWidget {
  final Database database;
  final User user;
  final BuildContext context;
  const ChatRooms({Key key, this.database, this.user, this.context})
      : super(key: key);

  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context);
    final user = Provider.of<User>(context);
    return ChatRooms(
      database: database,
      user: user,
      context: context,
    );
  }

  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  List<ChatRoom> list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchUsers(
                      list: list,
                      user: widget.user,
                      database: widget.database)));
        },
        child: Icon(Icons.add),
        backgroundColor: foregroundColor,
      ),
      body: StreamBuilder<List<ChatRoom>>(
        stream: widget.database.chatRoomsStream(userID: widget.user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            list = data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                String id = data[index]
                    .users
                    .where((element) => element != widget.user.uid)
                    .toString();
                id = id.substring(1, id.length - 1);
                return StreamBuilder<User>(
                    stream: widget.database.userStream(userId: id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final receiverUser = snapshot.data;
                        return ChatBubble(
                            lastMessage: data[index].lastMessage,
                            chatId: data[index].chatId,
                            senderUser: widget.user,
                            receiverUser: receiverUser,
                            database: widget.database);
                      } else {
                        return CircularProgressIndicator();
                      }
                    });
              },
            );
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Text("Error");
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
