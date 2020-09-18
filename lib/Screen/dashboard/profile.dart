import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mo8tarib/bloc/bloc.dart';
import 'package:mo8tarib/bloc/navigation_bloc.dart';
import 'package:mo8tarib/component/allHomeComponent/AvatarWidget.dart';
import 'package:mo8tarib/component/allHomeComponent/imageFlatWidget.dart';
import 'package:mo8tarib/global.dart';
import 'package:mo8tarib/model/post.dart';
import 'package:mo8tarib/model/post_mode.dart';
import 'package:mo8tarib/model/property_model.dart';

class Profile extends StatefulWidget with NavigationStates {
  final Function onMenuTap;

  const Profile(this.onMenuTap);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  ///
  List<String> image = [
    "https://media.gettyimages.com/photos/hotel-room-in-the-new-hotel-complex-in-moscow-picture-id871617622?s=612x612",
    "https://q-cf.bstatic.com/images/hotel/max1024x768/222/222713113.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQFHRtq_SQrHD4AepHJ79JGIa_rPg5uTj_wkw&usqp=CAU",
    "https://pix10.agoda.net/hotelImages/816/8162470/8162470_19062319400076757869.jpg?s=414x232&ar=16x9"
  ];

  double get randHeight => Random().nextInt(100).toDouble();

  List<Widget> _randomChildren;

  // Children with random heights - You can build your widgets of unknown heights here
  // I'm just passing the context in case if any widgets built here needs  access to context based data like Theme or MediaQuery
  List<Widget> _randomHeightWidgets(BuildContext context) {
    _randomChildren ??= List.generate(3, (index) {
      final height = randHeight.clamp(
        50.0,
        MediaQuery.of(context)
            .size
            .width, // simply using MediaQuery to demonstrate usage of context
      );
      return Container(
        color: Colors.primaries[index],
        height: height,
        child: Text('Random Height Child ${index + 1}'),
      );
    });

    return _randomChildren;
  }

  post_bloc _bloc;

  ///
  @override
  void initState() {
    _bloc = new post_bloc();
    _bloc.fetchAllPosts();
    getCurrentUser();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  String url;
  String firstNameText;
  String lastNameText;
  String address;
  var image1;

  Map<String, dynamic> map1 = {'first': 'ali', 'mid': 'ali', 'last': 'ali'};

  void getData() async {
    _fireStore
        .collection('user')
        .where("email", isEqualTo: loggedInUser.email)
        .snapshots()
        .listen((data) => data.documents.forEach((doc) {
              setState(() {
                url = doc['url'];
                map1 = doc['name'];
                firstNameText = map1['first'];
                lastNameText = map1['last'];
                address = doc['address'];

                print(url);
                print(map1['first']);
                print(map1['last']);
              });

              loadImage(url);
            }));
  }

  void loadImage(String url1) async {
    setState(() {
      image1 = NetworkImage(url1);
    });
  }

  DocumentReference user_id;
  DocumentReference flat_id;
  DocumentSnapshot _currentDocument;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Persistent AppBar that never scrolls
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          // allows you to build a list of elements that would be scrolled away till the body reached the top
          headerSliverBuilder: (context, _) {
            return [
              SliverAppBar(
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Profile', style: TextStyle(color: color2)),
                  centerTitle: true,
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: 30,
                    color: foregroundColor,
                  ),
                  onPressed: widget.onMenuTap,
                ),
                expandedHeight: 150,
                pinned: true,
                //floating: true,
                backgroundColor: color1,
                elevation: 5,
              )
//          SliverPersistentHeader(
//            pinned: true,
//            delegate: ,
//
//          )
            ];
          },

          // You tab view goes here
          body: Column(
            children: <Widget>[
              HeaderSection(
                  firstNameText: firstNameText,
                  lastNameText: lastNameText,
                  url: url,
                  adress: address),
              TabBar(
                indicatorColor: color1,
                tabs: [
                  Tab(
                      child:
                          Text('All posts', style: TextStyle(color: color2))),
                  Tab(
                      child:
                          Text('Posts Save', style: TextStyle(color: color2))),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: _fireStore.collection('flat').snapshots(),
                      builder: (context, snapshot) {
                        propertiesList.clear();
                        if (snapshot.hasData) {
                          final properties = snapshot.data.documents;
                          for (var property in properties) {
                            final UID = property.data['UID'];
                            if (UID == loggedInUser.uid) {
                              flat_id = property.reference;
                              _currentDocument = property;

                              print('flat id ///// $flat_id');
//
//              _fireStore
//                  .collection('user')
//                  .where("UID", isEqualTo: loggedInUser.uid)
//                  .snapshots()
//                  .listen(
//                    (data) => data.documents.forEach((doc) {
//                      final user_id = doc.reference;
//                      print('user id ///// $user_id');
//                    }),
//                  );

                              final price = property.data['price'];
                              final address = property.data['address'];
                              final url = property.data['imagesUrl'];
                              final description = property.data['description'];
                              final type = property.data['type'];
                              final category = property.data['category'];

                              var pro = Property(
                                url: url[0],
                                address: address,
                                description: description,
                                category: category,
                                type: type,
                                price: price,
                              );
                              propertiesList.add(pro);
                            }
                          }
                          print('${propertiesList.length}    /////');
                        } else {
                          print('no data found');
                        }

                        return ListView.builder(
                            itemCount: propertiesList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                color: Colors.white,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: _fireStore
                                        .collection('user')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final users = snapshot.data.documents;
                                        for (var user in users) {
                                          final UID = user.data['email'];
                                          if (UID == loggedInUser.email) {
                                            user_id = user.reference;
                                            print('user id ///// $user_id');
                                          }
                                        }
                                      } else {
                                        print('there no user');
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Card(
                                              elevation: 10,
                                              shadowColor: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Container(
                                                height: 300,
                                                child: Column(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Stack(
                                                        children: <Widget>[
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                                image: NetworkImage(
                                                                    propertiesList[
                                                                            index]
                                                                        .url),
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius.vertical(
                                                                      top: Radius
                                                                          .circular(
                                                                              30)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      flex: 2,
                                                    ),
                                                    Flexible(
                                                      flex: 1,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius: BorderRadius.vertical(
                                                                    bottom: Radius
                                                                        .circular(
                                                                            30)),
                                                                // color: Colors.white.withOpacity(0.5),
                                                                gradient: LinearGradient(
                                                                    begin: Alignment
                                                                        .topLeft,
                                                                    end: Alignment.bottomRight,
                                                                    colors: [
                                                                      Colors
                                                                          .teal,
                                                                      Colors
                                                                          .indigo
                                                                    ])),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 5),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                    FontAwesomeIcons
                                                                        .mapMarker,
                                                                    size: 15,
                                                                  ),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    propertiesList[
                                                                            index]
                                                                        .address,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    propertiesList[
                                                                            index]
                                                                        .type,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          10),
                                                                  Text(
                                                                    propertiesList[
                                                                            index]
                                                                        .category,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  )
                                                                ],
                                                              ),
                                                              Text(
                                                                propertiesList[
                                                                        index]
                                                                    .description,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                    FontAwesomeIcons
                                                                        .dollarSign,
                                                                    size: 15,
                                                                  ),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    propertiesList[
                                                                            index]
                                                                        .price,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
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
                                      );
                                    }),
                              );
                            });
                      },
                    ),
                    GridView.count(
                        padding: EdgeInsets.zero,
                        crossAxisCount: 3,
                        children: <Widget>[
                          for (int i = 0; i < image.length; i++)
                            imageFlatWidget(
                              image: NetworkImage(image[i]),
                            ),
                        ])
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final String firstNameText;
  final String lastNameText;
  final String url;
  final String adress;

  const HeaderSection(
      {Key key, this.firstNameText, this.lastNameText, this.url, this.adress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color1,
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image:
                  DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 5),
          Container(
            alignment: Alignment.center,
            child: Text(
              "$firstNameText $lastNameText",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: color2, fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
          SizedBox(height: 2),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Text(adress,
                textAlign: TextAlign.center, style: TextStyle(color: color2)),
          ),
          SizedBox(height: 5),
//          Container(
//            margin: EdgeInsets.symmetric(horizontal: 16),
//            child: Padding(
//              padding: EdgeInsets.only(left: 60, right: 50),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Column(
//                    children: <Widget>[
//                      Text(
//                        '4',
//                        style: TextStyle(
//                            color: color2, fontWeight: FontWeight.w600),
//                      ),
//                      Text('post', style: TextStyle(color: color2))
//                    ],
//                  ),
//                  Column(
//                    children: <Widget>[
//                      Text(
//                        '4',
//                        style: TextStyle(
//                            color: color2, fontWeight: FontWeight.w600),
//                      ),
//                      Text('Saved', style: TextStyle(color: color2))
//                    ],
//                  ),
//                ],
//              ),
//            ),
//          ),
//          SizedBox(height: 5),
        ],
      ),
    );
  }
}
