import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mo8tarib/Screen/post_details.dart';
import 'package:mo8tarib/Screen/rent.dart';
import 'package:mo8tarib/bloc/bloc.dart';
import 'package:mo8tarib/component/allHomeComponent/AvatarWidget.dart';
import 'package:mo8tarib/component/allHomeComponent/imageFlatWidget.dart';
import 'package:mo8tarib/model/post.dart';
import '../../../global.dart';
import '../../../localization.dart';

class GoHome extends StatefulWidget {
  final Size size;
  final String name;

  const GoHome({Key key, this.size, this.name}) : super(key: key);

  @override
  _GoHomeState createState() => _GoHomeState();
}

class _GoHomeState extends State<GoHome> {
  final _fireStore = Firestore.instance;
  FirebaseUser loggedInUser;
  final _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> flat = new List<Map<String, dynamic>>();
  List<Map<String, dynamic>> user = new List<Map<String, dynamic>>();

  List<String> allflatId = [];

  post_bloc _bloc;
  int height = 100;
  String name;
  var size;

  @override
  void initState() {
    super.initState();
    _bloc = new post_bloc();
    _bloc.fetchAllPosts();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

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

  List<String> image = [
    "https://media.gettyimages.com/photos/hotel-room-in-the-new-hotel-complex-in-moscow-picture-id871617622?s=612x612",
    "https://q-cf.bstatic.com/images/hotel/max1024x768/222/222713113.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQFHRtq_SQrHD4AepHJ79JGIa_rPg5uTj_wkw&usqp=CAU",
    "https://pix10.agoda.net/hotelImages/816/8162470/8162470_19062319400076757869.jpg?s=414x232&ar=16x9"
  ];

  // @override
//  void initState() {
//    super.initState();
//    name = widget.name;
//    size = widget.size;
//    getCurrentUser();
//    setState(() {
//
//    });
//  }

  @override
  Widget build(BuildContext context) {
//   if(flat.length==0){
//     return Center(
//       child:
//       RaisedButton(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius
//               .circular(20),
//         ),
//         color: Colors.indigo,
//         onPressed: () {
//           setState(() {
//
//           });
//         },
//         child: Text('refresh'),
//       )
//     );
//   }else {
    return Container(
        color: Colors.white70,
        child: StreamBuilder<List<post>>(
          stream: _bloc.streampost,
          builder: (context, allpost) {
            if (allpost.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(4),
                  shrinkWrap: true,
                  itemCount: allpost.data.length,
                  itemBuilder: (context, index) =>
                      StreamBuilder<DocumentSnapshot>(
                        stream: _fireStore
                            .collection('flat')
                            .document('${allpost.data[index].flat.documentID}')
                            .snapshots(),
                        builder: (context, data) {
                          if (data.hasData) {
                            return Padding(
                              padding: EdgeInsets.all(5),
                              child: AspectRatio(
                                aspectRatio: 0.8,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PostDetails(
                                            flatDocId:
                                                '${allpost.data[index].flat.documentID}',
                                            userDocId:
                                                '${allpost.data[index].user.documentID}',
                                          ),
                                        ));
                                    print('go to details');
//                                    Navigator.pushNamed(
//                                        context, '/postdetails');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: StreamBuilder<DocumentSnapshot>(
                                      stream: _fireStore
                                          .collection('user')
                                          .document(
                                              '${allpost.data[index].user.documentID}')
                                          .snapshots(),
                                      builder: (context, d) {
                                        if (d.hasData) {
                                          return Padding(
                                            padding: EdgeInsets.all(6),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      AvatarWidget(
                                                          radius: 20,
                                                          image: d.data[
                                                                      'url'] !=
                                                                  ''
                                                              ? NetworkImage(
                                                                  '${d.data['url']}')
                                                              : AssetImage(
                                                                  'images/person.png')),
                                                      //  SizedBox(width: size.width * .03),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                '${d.data['name']['first']} ${d.data['name']['last']}',
                                                                style: TextStyle(
                                                                    color:
                                                                        color1,
                                                                    fontSize:
                                                                        18)),
//                                                            SizedBox(width: 2),
//                                                            Text(
//                                                                '${d.data['name']['last']}',
//                                                                style: TextStyle(
//                                                                    color:
//                                                                        color1,
//                                                                    fontSize:
//                                                                        18)),
                                                            Text(
                                                                'since ${new DateFormat.yMMMd().format(allpost.data[index].time.toDate())}  m',
                                                                style: TextStyle(
                                                                    color:
                                                                        color1,
                                                                    fontSize:
                                                                        15)),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: SizedBox()),
                                                      IconButton(
                                                        icon: Icon(Icons
                                                            .favorite_border),
                                                        onPressed: () {},
                                                      )
                                                    ],
                                                  ),
                                                  Divider(
                                                    color: color1,
//                                          endIndent: size.width * .2,
//                                          indent: size.width * .2,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 2),
                                                    child: Text(
                                                      // 'tata',
                                                      "${data.data['category']}",
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: <Widget>[
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                    FontAwesomeIcons
                                                                        .mapMarkerAlt,
                                                                    size: 16,
                                                                  ),
                                                                  SizedBox(
                                                                      width: 3),
                                                                  Expanded(
                                                                    child: Text(
                                                                      // "Cairo",
                                                                      "${data.data['address']}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                    FontAwesomeIcons
                                                                        .building,
                                                                    size: 20,
                                                                  ),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    // 'tata',
                                                                    "room(${data.data['rooms']})",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                    FontAwesomeIcons
                                                                        .squarespace,
                                                                    size: 20,
                                                                  ),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    "${data.data['size']}M",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  )
                                                                ],
                                                              ),
                                                              RatingBar(
                                                                initialRating:
                                                                    3,
                                                                minRating: 1,
                                                                direction: Axis
                                                                    .horizontal,
                                                                allowHalfRating:
                                                                    true,
                                                                itemCount: 5,
                                                                itemSize: 20,
                                                                itemPadding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            2.0),
                                                                itemBuilder:
                                                                    (context,
                                                                            _) =>
                                                                        Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .amber,
                                                                  size: 10,
                                                                ),
                                                                onRatingUpdate:
                                                                    (rating) {
                                                                  print(rating);
                                                                },
                                                              ),
//                                                              Text(
//                                                                  ' 80 review'),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text('price',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20)),
                                                              Text(
                                                                  '${data.data['price']}\$',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          30)),
                                                              RaisedButton(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                color: Colors
                                                                    .indigo,
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                Rent(
                                                                          flatDocId:
                                                                              '${allpost.data[index].flat.documentID}',
                                                                          userDocId:
                                                                              '${allpost.data[index].user.documentID}',
                                                                        ),
                                                                      ));
                                                                },
                                                                child: Text(
                                                                    'Rent'),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10),
                                                      child: SizedBox(
                                                        height: 150,
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          physics:
                                                              ClampingScrollPhysics(),
                                                          itemCount: data
                                                              .data['imagesUrl']
                                                              .length,
                                                          itemBuilder: (context,
                                                                  index) =>
                                                              imageFlatWidget(
                                                            image: NetworkImage(
                                                                data.data[
                                                                        'imagesUrl']
                                                                    [index]),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15,
                                                        vertical: 5),
                                                    child: Row(
                                                      children: <Widget>[
                                                        AvatarWidget(
                                                            radius: 20,
                                                            image: d.data[
                                                                        'url'] !=
                                                                    ''
                                                                ? NetworkImage(
                                                                    '${d.data['url']}')
                                                                : AssetImage(
                                                                    'images/person.png')),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Expanded(
                                                          child: TextField(
                                                            textAlign: TextAlign
                                                                .center,
                                                            decoration:
                                                                KTextFieldDecoration
                                                                    .copyWith(
                                                              hintText:
                                                                  "Comment",
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                            icon: Icon(
                                                              Icons.send,
                                                              color: Colors
                                                                  .blueAccent,
                                                            ),
                                                            onPressed: () {})
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                          );
                                        } else {
                                          return Container(
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        }
                                      },
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
                        },
                      ));

//              Center(
//
//              child: Text(allpost.data[0].flat.snapshots()),
//            );
            } else {
              return Center(
                child: Text('no data'),
              );
            }
          },
        ));

//       Container(
//         color: Colors.white70,
//         child: ListView.builder(
//           padding: EdgeInsets.all(4),
//           shrinkWrap: true,
//           itemCount: flat.length,
//           itemBuilder: (context, index) =>
//               Padding(
//                 padding: EdgeInsets.all(5),
//                 child: AspectRatio(
//                   aspectRatio: 0.8,
//                   child: GestureDetector(
//                     onTap: () {
//                       print('go to details');
//                       Navigator.pushNamed(context, '/postdetails');
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.blueGrey.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(30)),
//                       child: Padding(
//                         padding: EdgeInsets.all(6),
//                         child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   AvatarWidget(
//                                       radius: 20,
//                                       image:
//                                       user[index]['url']!=null?
//                                         NetworkImage(
//                                           '${user[index]['url']}'):
//                                       AssetImage('images/person.png')
//                                   ),
//                                   SizedBox(width: size.width * .03),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment
//                                         .start,
//                                     children: [
//                                       Text(//'tata',
//                                           '${user[index]['name']['first']}',
//                                           style:
//                                           TextStyle(
//                                               color: color1, fontSize: 18)),
//                                       SizedBox(height: size.height * .007),
//                                       Text('since 2m',
//                                           style:
//                                           TextStyle(
//                                               color: color1, fontSize: 15)),
//                                     ],
//                                   ),
//                                   Expanded(child: SizedBox()),
//                                   IconButton(
//                                     icon: Icon(Icons.favorite_border),
//                                     onPressed: () {},
//                                   )
//                                 ],
//                               ),
//                               Divider(
//                                 color: color1,
//                                 endIndent: size.width * .2,
//                                 indent: size.width * .2,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 8),
//                                 child: Text(
//                                    "${flat[index]['category']}",
//                                   style: TextStyle(fontSize: 25),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment
//                                       .spaceAround,
//                                   children: <Widget>[
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment
//                                             .start,
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                         children: <Widget>[
//                                           Row(
//                                             children: <Widget>[
//                                               Icon(
//                                                 FontAwesomeIcons.mapMarkerAlt,
//                                                 size: 20,
//                                               ),
//                                               SizedBox(width: 5),
//                                               Text(
//                                                 "Cairo",
//                                                 style: TextStyle(fontSize: 18),
//                                               )
//                                             ],
//                                           ),
//                                           Row(
//                                             children: <Widget>[
//                                               Icon(
//                                                 FontAwesomeIcons.building,
//                                                 size: 20,
//                                               ),
//                                               SizedBox(width: 5),
//                                               Text(
//                                                 "room(${flat[index]['rooms']})",
//                                                 style: TextStyle(fontSize: 18),
//                                               )
//                                             ],
//                                           ),
//                                           Row(
//                                             children: <Widget>[
//                                               Icon(
//                                                 FontAwesomeIcons.squarespace,
//                                                 size: 20,
//                                               ),
//                                               SizedBox(width: 5),
//                                               Text(
//                                                 "100M",
//                                                 style: TextStyle(fontSize: 18),
//                                               )
//                                             ],
//                                           ),
//                                           RatingBar(
//                                             initialRating: 3,
//                                             minRating: 1,
//                                             direction: Axis.horizontal,
//                                             allowHalfRating: true,
//                                             itemCount: 5,
//                                             itemSize: 20,
//                                             itemPadding:
//                                             EdgeInsets.symmetric(
//                                                 horizontal: 2.0),
//                                             itemBuilder: (context, _) =>
//                                                 Icon(
//                                                   Icons.star,
//                                                   color: Colors.amber,
//                                                   size: 10,
//                                                 ),
//                                             onRatingUpdate: (rating) {
//                                               print(rating);
//                                             },
//                                           ),
//                                           Text(' 80 review'),
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         children: <Widget>[
//                                           Text('price',
//                                               style: TextStyle(fontSize: 20)),
//                                           Text('${flat[index]['price']}\$',
//                                               style: TextStyle(fontSize: 30)),
//                                           RaisedButton(
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius
//                                                   .circular(20),
//                                             ),
//                                             color: Colors.indigo,
//                                             onPressed: () {
//                                               print('object');
//                                               print(allflatId);
//                                               print(flat);
//                                             },
//                                             child: Text('Book'),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 10),
//                                   child: SizedBox(
//                                     height: 150,
//                                     child: ListView.builder(
//                                       shrinkWrap: true,
//                                       scrollDirection: Axis.horizontal,
//                                       physics: ClampingScrollPhysics(),
//                                       itemCount: image.length,
//                                       itemBuilder: (context, index) =>
//                                           imageFlatWidget(
//                                             image: NetworkImage(image[index]),
//                                           ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 15, vertical: 5),
//                                 child: Row(
//                                   children: <Widget>[
//                                     AvatarWidget(
//                                         radius: 20,
//                                         image: NetworkImage(
//                                             'https://greendestinations.org/wp-content/uploads/2019/05/avatar-exemple.jpg')
//                                       //AssetImage('images/person.png')
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Expanded(
//                                       child: TextField(
//                                         textAlign: TextAlign.center,
//                                         decoration: KTextFieldDecoration
//                                             .copyWith(
//                                           hintText: "Comment",
//                                         ),
//                                       ),
//                                     ),
//                                     IconButton(
//                                         icon: Icon(
//                                           Icons.send,
//                                           color: Colors.blueAccent,
//                                         ),
//                                         onPressed: () {})
//                                   ],
//                                 ),
//                               )
//                             ]),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//         ),
//       );
    // }
  }

  List<String> allflat = [];
  List<String> alluser = [];

  void getData() async {
    final Map<String, dynamic> f = new Map<String, dynamic>();
    final Map<String, dynamic> u = new Map<String, dynamic>();

    //  getCurrentUser();
    await _fireStore
        .collection('post')
        .snapshots()
        .listen((data) => data.documents.forEach((doc) async {
              allflat.add(doc['flat_id'].documentID);
              alluser.add(doc['user_id'].documentID);

              await _fireStore
                  .collection('flat')
                  .document(doc['flat_id'].documentID)
                  .get()
                  .then((DocumentSnapshot) {
                f['user_id'] = DocumentSnapshot.data['UID'];
                f['bathroom'] = DocumentSnapshot.data['bathroom'];
                f['category'] = DocumentSnapshot.data['category'];
                f['description'] = DocumentSnapshot.data['description'];
                f['duration'] = DocumentSnapshot.data['duration'];
                f['imagesUrl'] = DocumentSnapshot.data['imagesUrl'];
                f['kitchen'] = DocumentSnapshot.data['kitchen'];
                f['price'] = DocumentSnapshot.data['price'];
                f['rooms'] = DocumentSnapshot.data['rooms'];
                f['serives'] = DocumentSnapshot.data['serives'];
                f['size'] = DocumentSnapshot.data['size'];
                f['type'] = DocumentSnapshot.data['type'];
                flat.add(f);
                print(DocumentSnapshot.data['category'].toString());
              });

              await _fireStore
                  .collection('user')
                  .document(doc['user_id'].documentID)
                  .get()
                  .then((DocumentSnapshot) {
                u['address'] = DocumentSnapshot.data['address'];
                u['age'] = DocumentSnapshot.data['age'];
                u['email'] = DocumentSnapshot.data['email'];
                u['location'] = DocumentSnapshot.data['location'];
                u['name'] = DocumentSnapshot.data['name'];
                u['phone'] = DocumentSnapshot.data['phone'];
                u['url'] = DocumentSnapshot.data['url'];
                user.add(u);
                print(DocumentSnapshot.data['phone'].toString());
              });
            }));
  }

  final List<Map<String, dynamic>> flat1 = new List<Map<String, dynamic>>();

  void getflat(List<String> id) async {
    getData();
    print(allflat.length);
    final Map<String, dynamic> f = new Map<String, dynamic>();
    print(allflat);
    for (int i = 0; i < allflat.length; i++) {
      _fireStore
          .collection('flat')
          .document('j86n8nCBiFY6hpYeO0ta')
          .get()
          .then((DocumentSnapshot) {
        f['user_id'] = DocumentSnapshot.data['UID'];
        f['bathroom'] = DocumentSnapshot.data['bathroom'];
        f['category'] = DocumentSnapshot.data['category'];
        f['description'] = DocumentSnapshot.data['description'];
        f['duration'] = DocumentSnapshot.data['duration'];
        f['imagesUrl'] = DocumentSnapshot.data['imagesUrl'];
        f['kitchen'] = DocumentSnapshot.data['kitchen'];
        f['price'] = DocumentSnapshot.data['price'];
        f['rooms'] = DocumentSnapshot.data['rooms'];
        f['serives'] = DocumentSnapshot.data['serives'];
        f['size'] = DocumentSnapshot.data['size'];
        f['type'] = DocumentSnapshot.data['type'];
        flat.add(f);
        print(DocumentSnapshot.data['category'].toString());
      });
    }
    setState(() {});
  }
}
