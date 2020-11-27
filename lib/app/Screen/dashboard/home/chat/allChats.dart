import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/global.dart';

//AllChats
class AllChats extends StatefulWidget {
  @override
  _AllChatsState createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  int whichAtive = 1;
  final _fireStore = Firestore.instance;
  FirebaseUser loggedInUser;
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(user.email);
        getData();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('user').snapshots(),
        builder: (context, data) {
          if (data.hasData) {
            final user = data.data.documents.reversed.toList();
            return ListView.builder(
              padding: EdgeInsets.all(4),
              shrinkWrap: true,
              itemCount: user.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(5),
                child: AspectRatio(
                  aspectRatio: size.width * .008,
                  child: GestureDetector(
                    onTap: () {
                      print("tata");
                      print(allUserId[index]);
                      print(allUsername[index]);
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => (Messages(
//                                  '${user[index]["name"]["first"]}',
//                                  id,
//                                  user[index].documentID))));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
//                                  AvatarWidget(
//                                      radius: 40,
//                                      image: user[index]['url'] != ''
//                                          ? NetworkImage(
//                                              "${user[index]['url']}")
//                                          : AssetImage('images/person.png')
//                                      // CachedNetworkImageProvider('https://greendestinations.org/wp-content/uploads/2019/05/avatar-exemple.jpg'),
//                                      ),
                                  SizedBox(width: size.width * .03),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${user[index]["name"]["first"]} ${user[index]["name"]["mid"]}',
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
                ),
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  List<String> allUserId = [];
  List<String> allUserUrl = [];
  String id = "";
  List<Map<String, dynamic>> allUsername = [];

  void getData() async {
    print('xxxxxxxxxxxxxxxxxxxxxx');
    Stream<QuerySnapshot> au = _fireStore.collection('user').snapshots();
    print('xxxxxxxxxxxxxxxxxxxxxx');
    au.listen((data) => data.documents.forEach((doc) {
          print(loggedInUser.email);
          print(doc["email"]);
          if (loggedInUser.email == doc["email"]) {
            id = doc.documentID;
          } else {
            allUserId.add(doc.documentID);
            allUserUrl.add(doc['url']);
            allUsername.add({
              'first': doc['name']['first'],
              'mid': doc['name']['mid'],
              'last': doc['name']['last']
            });
            print(doc.documentID);
            print(doc['name']['first']);
            print(doc['url']);
            setState(() {});
          }
        }));
  }
}
