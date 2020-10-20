import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mo8tarib/app/Screen/location_flat.dart';
import 'package:mo8tarib/app/Screen/rent.dart';
import 'package:mo8tarib/app/common_widgets/allHomeComponent/AvatarWidget.dart';
import 'package:mo8tarib/app/common_widgets/allHomeComponent/imageFlatWidget.dart';
import 'package:mo8tarib/app/common_widgets/message_bubble.dart';
import 'package:mo8tarib/app/common_widgets/search_components.dart';

import 'package:mo8tarib/global.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

class PostDetails extends StatefulWidget {
  final String flatDocId;
  final String userDocId;

  const PostDetails({Key key, this.flatDocId, this.userDocId})
      : super(key: key);

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  String url;
  final _fireStore = Firestore.instance;
  FirebaseUser loggedInUser;
  final _auth = FirebaseAuth.instance;
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();

      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        getData();
      }
    } catch (e) {
      print("error in menu");
    }
  }

  void getData() async {
    _fireStore
        .collection('user')
        .where("email", isEqualTo: loggedInUser.email)
        .snapshots()
        .listen((data) => data.documents.forEach((doc) {
              setState(() {
                url = doc['url'];
              });

              //loadImage(url);
            }));
  }

  double screenWidth, screenHeight;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    Map<String, dynamic> mapName = {
      'first': 'ali',
      'mid': 'ali',
      'last': 'ali'
    };

    return Material(
      child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('flat')
              .document(widget.flatDocId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            }
            var flatDocument = snapshot.data;
            return StreamBuilder<DocumentSnapshot>(
                stream: Firestore.instance
                    .collection('user')
                    .document(widget.userDocId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return new Text("Loading");
                  }
                  var userDocument = snapshot.data;

                  print(userDocument['url']);

                  return Container(
                    child: Stack(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height: 350,
                                    width: screenWidth,
                                    child: ListView.builder(
                                      // shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: ClampingScrollPhysics(),
                                      itemCount:
                                          flatDocument['imagesUrl'].length,
                                      itemBuilder: (context, index) =>
                                          imageFlatWidget(
                                        image: NetworkImage(
                                            flatDocument['imagesUrl'][index]),
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 22, horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            IconButton(
                                                icon: Icon(
                                                  Icons.arrow_back,
                                                  color: backgroundColor2,
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }),
                                            Row(
                                              children: <Widget>[
                                                IconButton(
                                                  icon: Icon(
                                                      Icons.favorite_border),
                                                  onPressed: () {},
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                      Icons.bookmark_border),
                                                  onPressed: () {},
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 15, 0),
                                          child: AvatarWidget(
                                              radius: 20,
                                              image: userDocument['url'] != ''
                                                  ? NetworkImage(
                                                      "${userDocument['url']}")
                                                  : AssetImage(
                                                      'images/person.png')),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                  '${userDocument['name']['first']} ${userDocument['name']['last']}',
                                                  style: TextStyle(
                                                      color: color1,
                                                      fontSize: 18)),
                                              Text('Owner',
                                                  style: TextStyle(
                                                      color: color1,
                                                      fontSize: 18)),
                                            ],
                                          ),
                                        ),
                                        Text('\$',
                                            style: TextStyle(
                                                fontFamily: 'VarelaRound',
                                                fontSize: 30)),
                                        Text(flatDocument['price'],
                                            style: TextStyle(
                                                fontFamily: 'VarelaRound',
                                                fontSize: 30)),
                                        Text(' / day',
                                            style: TextStyle(
                                                fontFamily: 'VarelaRound',
                                                fontSize: 20))
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .mapMarkerAlt,
                                                      size: 25,
                                                      color: foregroundColor,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8),
                                                      child: Text(
                                                        flatDocument['address'],
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                  icon: Icon(Icons.near_me,
                                                      size: 25,
                                                      color: foregroundColor),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              LocationFlat(
                                                            docId: widget
                                                                .flatDocId,
                                                          ),
                                                        ));
                                                  })
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Icon(FontAwesomeIcons.bed,
                                                    size: 20),
                                                //SizedBox(width: 15),
                                                Text(flatDocument['rooms'],
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                                Icon(
                                                    FontAwesomeIcons
                                                        .squarespace,
                                                    size: 20),
                                                //SizedBox(width: 15),
                                                Text(flatDocument['size'],
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                                Icon(FontAwesomeIcons.user,
                                                    size: 20),
                                                //SizedBox(width: 15),
                                                Text(flatDocument['Gender'],
                                                    style:
                                                        TextStyle(fontSize: 18))
                                              ]),
                                          // SizedBox(height: 10),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14),
                                              child: Text('Describtion',
                                                  style: TextStyle(
                                                      fontFamily: 'VarelaRound',
                                                      fontSize: 22))),
                                          Text(flatDocument['description']),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 14),
                                                  child: Text('Property Type',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'VarelaRound',
                                                          fontSize: 22))),
                                              Text(flatDocument['type'],
                                                  style: TextStyle(
                                                      fontFamily: 'VarelaRound',
                                                      fontSize: 20,
                                                      color: foregroundColor)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 14),
                                                  child: Text(
                                                      'Property Category',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'VarelaRound',
                                                          fontSize: 22))),
                                              Text(flatDocument['category'],
                                                  style: TextStyle(
                                                      fontFamily: 'VarelaRound',
                                                      fontSize: 20,
                                                      color: foregroundColor)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('From'),
                                              Text(flatDocument['timestart'],
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily:
                                                          'VarelaRound')),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text('To'),
                                              Text(flatDocument['timeend'],
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily:
                                                          'VarelaRound')),
                                            ],
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14),
                                              child: Text('Servies',
                                                  style: TextStyle(
                                                      fontFamily: 'VarelaRound',
                                                      fontSize: 22))),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Column(
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons.wifi,
                                                      size: 25,
                                                      color: foregroundColor,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text('Wifi')
                                                  ],
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons.carAlt,
                                                      size: 25,
                                                      color: foregroundColor,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text('parkink')
                                                  ],
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons.fan,
                                                      size: 25,
                                                      color: foregroundColor,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text('Air condiotioning')
                                                  ],
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons.dog,
                                                      size: 25,
                                                      color: foregroundColor,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text('animals')
                                                  ],
                                                ),
                                              ]

//                                                ConditionalSwitch.list<String>(
//                                              context: context,
//                                              valueBuilder:
//                                                  (BuildContext context) => 'A',
//                                              caseBuilders: {
//                                                'A': (BuildContext context) =>
//                                                    <Widget>[
//                                                      Text('Widget A'),
//                                                      Text('Widget B'),
//                                                    ],
//                                                'B': (BuildContext context) =>
//                                                    <Widget>[
//                                                      Text('Widget C'),
//                                                      Text('Widget D'),
//                                                    ],
//                                              },
//                                              fallbackBuilder:
//                                                  (BuildContext context) =>
//                                                      <Widget>[
//                                                Text(
//                                                    'None of the cases matched!'),
//                                              ],
//                                            ),

//                                            <Widget>[
//                                              Column(
//                                                children: <Widget>[
//                                                  Icon(
//                                                    FontAwesomeIcons.wifi,
//                                                    size: 25,
//                                                    color: foregroundColor,
//                                                  ),
//                                                  SizedBox(
//                                                    height: 10,
//                                                  ),
//                                                  Text('Wifi')
//                                                ],
//                                              ),
//                                              Column(
//                                                children: <Widget>[
//                                                  Icon(
//                                                    FontAwesomeIcons.carAlt,
//                                                    size: 25,
//                                                    color: foregroundColor,
//                                                  ),
//                                                  SizedBox(
//                                                    height: 10,
//                                                  ),
//                                                  Text('parkink')
//                                                ],
//                                              ),
//                                              Column(
//                                                children: <Widget>[
//                                                  Icon(
//                                                    FontAwesomeIcons.fan,
//                                                    size: 25,
//                                                    color: foregroundColor,
//                                                  ),
//                                                  SizedBox(
//                                                    height: 10,
//                                                  ),
//                                                  Text('Air condiotioning')
//                                                ],
//                                              ),
//                                              Column(
//                                                children: <Widget>[
//                                                  Icon(
//                                                    FontAwesomeIcons.dog,
//                                                    size: 25,
//                                                    color: foregroundColor,
//                                                  ),
//                                                  SizedBox(
//                                                    height: 10,
//                                                  ),
//                                                  Text('animals')
//                                                ],
//                                              ),
//                                            ],
                                              ),
                                          SizedBox(
                                            height: 14,
                                          ),
                                          RatingBar(
                                            initialRating: 3,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 25,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 2.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 10,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                          Text(' 80 review'),
                                          Column(
                                            children: <Widget>[
                                              MessageBubble(
                                                sender: 'hussen',
                                                text: 'good',
                                                isMe: false,
                                              ),
                                              MessageBubble(
                                                sender: 'ali',
                                                text: 'bad',
                                                isMe: false,
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Row(
                                              children: <Widget>[
                                                AvatarWidget(
                                                    radius: 20,
                                                    image: NetworkImage(url
//                                                        'https://greendestinations.org/wp-content/uploads/2019/05/avatar-exemple.jpg'
                                                        )
                                                    //AssetImage('images/person.png')
                                                    // CachedNetworkImageProvider('https://greendestinations.org/wp-content/uploads/2019/05/avatar-exemple.jpg'),
                                                    ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                    textAlign: TextAlign.center,
                                                    decoration:
                                                        KTextFieldDecoration
                                                            .copyWith(
                                                      hintText: "Comment",
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                    icon: Icon(
                                                      Icons.send,
                                                      color: Colors.blueAccent,
                                                    ),
                                                    onPressed: () {})
                                              ],
                                            ),
                                          ),
                                          Container(height: 50)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  child: SearchRaisedButton(
                                    title: 'Contact',
                                    textColor: Colors.black,
                                    color: Colors.white,
                                    function: () {
                                      print('clear button');
                                    },
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: SearchRaisedButton(
                                    title: 'Booking',
                                    color: foregroundColor,
                                    textColor: Colors.white,
                                    function: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Rent(
                                              flatDocId: widget.flatDocId,
                                              userDocId: widget.userDocId,
                                            ),
                                          ));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
