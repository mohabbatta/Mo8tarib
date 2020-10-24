import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/app/bloc/navigation_bloc.dart';
import 'package:mo8tarib/app/common_widgets/avatar.dart';

import 'package:mo8tarib/global.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget with NavigationStates {
  final Function onMenuTap;

  const Profile(this.onMenuTap);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            size: 30,
            color: foregroundColor,
          ),
          onPressed: widget.onMenuTap,
        ),
        bottom: PreferredSize(
            child: _buildUserInfo(user), preferredSize: Size.fromHeight(130)),
      ),
    );
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: <Widget>[
        Avatar(photoUrl: user.photoUrl, radius: 50),
        SizedBox(height: 8),
        if (user.disPlayName != null)
          Text(
            user.disPlayName,
            style: TextStyle(color: Colors.white),
          ),
        SizedBox(height: 8)
      ],
    );
  }
}

//  double get randHeight => Random().nextInt(100).toDouble();
//
//  List<Widget> _randomChildren;
//
//  // Children with random heights - You can build your widgets of unknown heights here
//  // I'm just passing the context in case if any widgets built here needs  access to context based data like Theme or MediaQuery
//  List<Widget> _randomHeightWidgets(BuildContext context) {
//    _randomChildren ??= List.generate(3, (index) {
//      final height = randHeight.clamp(
//        50.0,
//        MediaQuery.of(context)
//            .size
//            .width, // simply using MediaQuery to demonstrate usage of context
//      );
//      return Container(
//        color: Colors.primaries[index],
//        height: height,
//        child: Text('Random Height Child ${index + 1}'),
//      );
//    });
//
//    return _randomChildren;
//  }
//
//  void loadImage(String url1) async {
//    setState(() {
//      image1 = NetworkImage(url1);
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final user = Provider.of<User>(context);
//    return Scaffold(
//      // Persistent AppBar that never scrolls
//      body: DefaultTabController(
//        length: 2,
//        child: NestedScrollView(
//          // allows you to build a list of elements that would be scrolled away till the body reached the top
//          headerSliverBuilder: (context, _) {
//            return [
//              SliverAppBar(
//                flexibleSpace: FlexibleSpaceBar(
//                  title: Text('Profile', style: TextStyle(color: color2)),
//                  centerTitle: true,
//                ),
//                leading: IconButton(
//                  icon: Icon(
//                    Icons.menu,
//                    size: 30,
//                    color: foregroundColor,
//                  ),
//                  onPressed: widget.onMenuTap,
//                ),
//                expandedHeight: 150,
//                pinned: true,
//                //floating: true,
//                backgroundColor: color1,
//                elevation: 5,
//              )
////          SliverPersistentHeader(
////            pinned: true,
////            delegate: ,
////
////          )
//            ];
//          },
//
//          // You tab view goes here
//          body: Column(
//            children: <Widget>[
//              HeaderSection(
//                disPlayName: user.disPlayName,
//                url: user.photoUrl,
//              ),
//              TabBar(
//                indicatorColor: color1,
//                tabs: [
//                  Tab(
//                      child:
//                          Text('All posts', style: TextStyle(color: color2))),
//                  Tab(
//                      child:
//                          Text('Posts Save', style: TextStyle(color: color2))),
//                ],
//              ),
//              Expanded(
//                child: TabBarView(
//                  children: [
//                    StreamBuilder<QuerySnapshot>(
//                      stream: _fireStore.collection('flat').snapshots(),
//                      builder: (context, snapshot) {
//                        propertiesList.clear();
//                        if (snapshot.hasData) {
//                          final properties = snapshot.data.documents;
//                          for (var property in properties) {
//                            final UID = property.data['UID'];
//                            if (UID == loggedInUser.uid) {
//                              flat_id = property.reference;
//                              _currentDocument = property;
//
//                              print('flat id ///// $flat_id');
////
////              _fireStore
////                  .collection('user')
////                  .where("UID", isEqualTo: loggedInUser.uid)
////                  .snapshots()
////                  .listen(
////                    (data) => data.documents.forEach((doc) {
////                      final user_id = doc.reference;
////                      print('user id ///// $user_id');
////                    }),
////                  );
//
//                              final price = property.data['price'];
//                              final address = property.data['address'];
//                              final url = property.data['imagesUrl'];
//                              final description = property.data['description'];
//                              final type = property.data['type'];
//                              final category = property.data['category'];
//
//                              var pro = Property(
//                                url: url[0],
//                                address: address,
//                                description: description,
//                                category: category,
//                                type: type,
//                                price: price,
//                              );
//                              propertiesList.add(pro);
//                            }
//                          }
//                          print('${propertiesList.length}    /////');
//                        } else {
//                          print('no data found');
//                        }
//
//                        return ListView.builder(
//                            itemCount: propertiesList.length,
//                            itemBuilder: (context, index) {
//                              return Container(
//                                color: Colors.white,
//                                child: StreamBuilder<QuerySnapshot>(
//                                    stream: _fireStore
//                                        .collection('user')
//                                        .snapshots(),
//                                    builder: (context, snapshot) {
//                                      if (snapshot.hasData) {
//                                        final users = snapshot.data.documents;
//                                        for (var user in users) {
//                                          final UID = user.data['email'];
//                                          if (UID == loggedInUser.email) {
//                                            user_id = user.reference;
//                                            print('user id ///// $user_id');
//                                          }
//                                        }
//                                      } else {
//                                        print('there no user');
//                                      }
//                                      return Padding(
//                                        padding: const EdgeInsets.all(20),
//                                        child: Column(
//                                          crossAxisAlignment:
//                                              CrossAxisAlignment.stretch,
//                                          children: <Widget>[
//                                            Card(
//                                              elevation: 10,
//                                              shadowColor: Colors.black,
//                                              shape: RoundedRectangleBorder(
//                                                borderRadius:
//                                                    BorderRadius.circular(30),
//                                              ),
//                                              child: Container(
//                                                height: 300,
//                                                child: Column(
//                                                  children: <Widget>[
//                                                    Flexible(
//                                                      child: Stack(
//                                                        children: <Widget>[
//                                                          Container(
//                                                            decoration:
//                                                                BoxDecoration(
//                                                              image:
//                                                                  DecorationImage(
//                                                                fit: BoxFit
//                                                                    .fitWidth,
//                                                                image: NetworkImage(
//                                                                    propertiesList[
//                                                                            index]
//                                                                        .url),
//                                                              ),
//                                                              borderRadius:
//                                                                  BorderRadius.vertical(
//                                                                      top: Radius
//                                                                          .circular(
//                                                                              30)),
//                                                            ),
//                                                          ),
//                                                        ],
//                                                      ),
//                                                      flex: 2,
//                                                    ),
//                                                    Flexible(
//                                                      flex: 1,
//                                                      child: Container(
//                                                        decoration:
//                                                            BoxDecoration(
//                                                                borderRadius: BorderRadius.vertical(
//                                                                    bottom: Radius
//                                                                        .circular(
//                                                                            30)),
//                                                                // color: Colors.white.withOpacity(0.5),
//                                                                gradient: LinearGradient(
//                                                                    begin: Alignment
//                                                                        .topLeft,
//                                                                    end: Alignment.bottomRight,
//                                                                    colors: [
//                                                                      Colors
//                                                                          .teal,
//                                                                      Colors
//                                                                          .indigo
//                                                                    ])),
//                                                        child: Padding(
//                                                          padding:
//                                                              const EdgeInsets
//                                                                      .symmetric(
//                                                                  horizontal:
//                                                                      10,
//                                                                  vertical: 5),
//                                                          child: Column(
//                                                            crossAxisAlignment:
//                                                                CrossAxisAlignment
//                                                                    .stretch,
//                                                            mainAxisAlignment:
//                                                                MainAxisAlignment
//                                                                    .spaceBetween,
//                                                            children: <Widget>[
//                                                              Row(
//                                                                children: <
//                                                                    Widget>[
//                                                                  Icon(
//                                                                    FontAwesomeIcons
//                                                                        .mapMarker,
//                                                                    size: 15,
//                                                                  ),
//                                                                  SizedBox(
//                                                                      width: 5),
//                                                                  Text(
//                                                                    propertiesList[
//                                                                            index]
//                                                                        .address,
//                                                                    style: TextStyle(
//                                                                        fontSize:
//                                                                            18),
//                                                                  )
//                                                                ],
//                                                              ),
//                                                              Row(
//                                                                children: <
//                                                                    Widget>[
//                                                                  Text(
//                                                                    propertiesList[
//                                                                            index]
//                                                                        .type,
//                                                                    style: TextStyle(
//                                                                        fontSize:
//                                                                            18),
//                                                                  ),
//                                                                  SizedBox(
//                                                                      width:
//                                                                          10),
//                                                                  Text(
//                                                                    propertiesList[
//                                                                            index]
//                                                                        .category,
//                                                                    style: TextStyle(
//                                                                        fontSize:
//                                                                            18),
//                                                                  )
//                                                                ],
//                                                              ),
//                                                              Text(
//                                                                propertiesList[
//                                                                        index]
//                                                                    .description,
//                                                                style: TextStyle(
//                                                                    fontSize:
//                                                                        18),
//                                                              ),
//                                                              Row(
//                                                                children: <
//                                                                    Widget>[
//                                                                  Icon(
//                                                                    FontAwesomeIcons
//                                                                        .dollarSign,
//                                                                    size: 15,
//                                                                  ),
//                                                                  SizedBox(
//                                                                      width: 5),
//                                                                  Text(
//                                                                    propertiesList[
//                                                                            index]
//                                                                        .price,
//                                                                    style: TextStyle(
//                                                                        fontSize:
//                                                                            18),
//                                                                  )
//                                                                ],
//                                                              ),
//                                                            ],
//                                                          ),
//                                                        ),
//                                                      ),
//                                                    ),
//                                                  ],
//                                                ),
//                                              ),
//                                            )
//                                          ],
//                                        ),
//                                      );
//                                    }),
//                              );
//                            });
//                      },
//                    ),
//                    GridView.count(
//                        padding: EdgeInsets.zero,
//                        crossAxisCount: 3,
//                        children: <Widget>[
//                          for (int i = 0; i < image.length; i++)
//                            imageFlatWidget(
//                              image: NetworkImage(image[i]),
//                            ),
//                        ])
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
//
//class HeaderSection extends StatelessWidget {
//  final String disPlayName;
//  final String url;
//
//  const HeaderSection({Key key, this.url, this.disPlayName}) : super(key: key);
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      color: color1,
//      child: Column(
//        children: <Widget>[
//          Container(
//            height: 100,
//            width: 100,
//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(100),
//              image:
//                  DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
//            ),
//          ),
//          SizedBox(height: 5),
//          Container(
//            alignment: Alignment.center,
//            child: Text(
//              "$firstNameText $lastNameText",
//              textAlign: TextAlign.center,
//              style: TextStyle(
//                  color: color2, fontWeight: FontWeight.w600, fontSize: 20),
//            ),
//          ),
//          SizedBox(height: 2),
//          Container(
//            margin: EdgeInsets.symmetric(horizontal: 20),
//            alignment: Alignment.center,
//            child: Text(adress,
//                textAlign: TextAlign.center, style: TextStyle(color: color2)),
//          ),
//          SizedBox(height: 5),
////          Container(
////            margin: EdgeInsets.symmetric(horizontal: 16),
////            child: Padding(
////              padding: EdgeInsets.only(left: 60, right: 50),
////              child: Row(
////                mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                children: <Widget>[
////                  Column(
////                    children: <Widget>[
////                      Text(
////                        '4',
////                        style: TextStyle(
////                            color: color2, fontWeight: FontWeight.w600),
////                      ),
////                      Text('post', style: TextStyle(color: color2))
////                    ],
////                  ),
////                  Column(
////                    children: <Widget>[
////                      Text(
////                        '4',
////                        style: TextStyle(
////                            color: color2, fontWeight: FontWeight.w600),
////                      ),
////                      Text('Saved', style: TextStyle(color: color2))
////                    ],
////                  ),
////                ],
////              ),
////            ),
////          ),
////          SizedBox(height: 5),
//        ],
//      ),
//    );
//  }
//}
