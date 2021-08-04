import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mo8tarib/app/Screen/dashboard/property/property_model.dart';
import 'package:mo8tarib/constants/color_constants.dart';
import 'package:mo8tarib/constants/global.dart';

class SearchResult extends StatefulWidget {
  final List<String> result;

  const SearchResult({Key key, this.result}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final _fireStore = FirebaseFirestore.instance;
  final List<String> find = [];
  User loggedInUser;
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user =  _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(user.email);
        //getData();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Result',
          style: TextStyle(
            color: ColorConstants.primaryColor,
          ),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: ColorConstants.primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('flat').snapshots(),
        builder: (context, snapshot) {
          //propertiesList.clear();
          if (snapshot.hasData) {
            final properties = snapshot.data.docs;
            for (var property in properties) {
              final uID = property.id;
              // int i = 0;
              for (int i = 0; i < widget.result.length; i++) {
                if (uID == widget.result[i]) {
                  final price = property['price'];
                  final address = property['address'];
                  // final url = property['imagesUrl'];
                  final description = property['description'];
                  final type = property['type'];
                  final category = property['category'];

                  var pro = Property(
                    pid: 'xx',
                    uid: 'xx',
                    // url: url[0],
                    address: address,
                    description: description,
                    category: category,
                    type: type,
                    price: price,
                  );
                  // propertiesList.add(pro);
                }
              }
            }
            //   print('${propertiesList.length}    /////');
          } else {
            print('no data found');
          }
          return ListView.builder(
              //   itemCount: propertiesList.length,
              itemBuilder: (context, index) {
            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      elevation: 10,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Container(
                        height: 300,
                        child: Column(
                          children: <Widget>[
//                                Flexible(
//                                  child: Container(
//                                    decoration: BoxDecoration(
//                                      image: DecorationImage(
//                                        fit: BoxFit.fitWidth,
//                                        image: NetworkImage(
//                                            propertiesList[index].url),
//                                      ),
//                                      borderRadius: BorderRadius.vertical(
//                                          top: Radius.circular(30)),
//                                    ),
//                                  ),
//                                  flex: 2,
//                                ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(30)),
                                    // color: Colors.white.withOpacity(0.5),
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [Colors.teal, Colors.indigo])),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.mapMarker,
                                            size: 15,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            " propertiesList[index].address",
                                            style: TextStyle(fontSize: 18),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "propertiesList[index].type",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "propertiesList[index].category",
                                            style: TextStyle(fontSize: 18),
                                          )
                                        ],
                                      ),
                                      Text(
                                        " propertiesList[index].description",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.dollarSign,
                                            size: 15,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            " propertiesList[index].price",
                                            style: TextStyle(fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
