import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/chat/chat_bubble.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/global.dart';
import 'package:mo8tarib/services/data_base.dart';

class SearchUsers extends StatefulWidget {
  final User user;
  final Database database;

  const SearchUsers({Key key, this.user, this.database}) : super(key: key);

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
                  return ChatBubble(
                      senderUser: widget.user,
                      receiverUser: _resultsList[index]);
                }),
          ),
        ],
      ),
    );
  }
}
