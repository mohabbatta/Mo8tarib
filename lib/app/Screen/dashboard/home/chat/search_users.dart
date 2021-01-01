import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/chat/messages.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/chat/model/chat_room_model.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/app/common_widgets/avatar.dart';
import 'package:mo8tarib/global.dart';
import 'package:mo8tarib/services/data_base.dart';

class SearchUsers extends StatefulWidget {
  final User user;
  final Database database;
  final List<ChatRoom> list;

  const SearchUsers({Key key, this.user, this.database, this.list})
      : super(key: key);

  @override
  _SearchUsersState createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  TextEditingController _searchController = TextEditingController();

  List<User> _allResults = [];
  List _resultsList = [];
  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != null) {
      for (var user in _allResults) {
        var name = user.disPlayName.toLowerCase();

        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(user);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }

    setState(() {
      _resultsList = showResults;
    });
  }

  void getData() async {
    print('xxxxxxxxxxxxxxxxxxxxxx');
    Firestore.instance
        .collection('mohab_users')
        .snapshots()
        .listen((data) => data.documents.forEach((doc) {
              setState(() {
                _allResults.add(User.fromMap(doc.data, doc.documentID));
              });
            }));
    searchResultsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: foregroundColor,
        ),
        backgroundColor: Colors.white,
        title: Text("New Message", style: TextStyle(color: foregroundColor)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(fontSize: 22, color: Colors.black),
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search User",
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _resultsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: GestureDetector(
                    onTap: () {
                      var id = _resultsList[index].uid;
                      List<ChatRoom> room = widget.list
                          .where((element) => element.users.contains(id))
                          .toList();
                      if (room.isNotEmpty && room[0] != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => (Messages(
                                      chatId: room[0].chatId,
                                      senderUser: widget.user,
                                      receiverUser: _resultsList[index],
                                      database: widget.database,
                                    ))));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => (Messages(
                                      // chatId: chatId ?? senderUser.uid + receiverUser.uid,
                                      senderUser: widget.user,
                                      receiverUser: _resultsList[index],
                                      database: widget.database,
                                    ))));
                      }
                    },
                    child: Container(
//                      decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(30),
//                          color: Colors.black12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Avatar(
                                  photoUrl: _resultsList[index].photoUrl,
                                  radius: 30),
                              SizedBox(width: 10),
                              Text(
                                _resultsList[index].disPlayName,
                                style: TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
