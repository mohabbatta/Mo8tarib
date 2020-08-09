import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mo8tarib/bloc/navigation_bloc.dart';
import 'package:mo8tarib/component/allHomeComponent/AvatarWidget.dart';
import 'package:mo8tarib/component/allHomeComponent/imageFlatWidget.dart';
import 'package:mo8tarib/component/data_search.dart';
import 'package:mo8tarib/global.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:mo8tarib/localization.dart';

import 'package:provider/provider.dart';
import 'insidehome/GoHome.dart';
import 'insidehome/allChats.dart';
import 'insidehome/find.dart';
import 'insidehome/messages.dart';
import 'insidehome/search.dart';
//
//class HomeDas extends StatefulWidget with NavigationStates {
//  final Function onMenuTap;
//  const HomeDas(this.onMenuTap);
//
//  @override
//  _HomeDasState createState() => _HomeDasState();
//}
//
//class _HomeDasState extends State<HomeDas> {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Moغtrsb',
//      home: BlocProvider(
//        create: (context) => BottomNavigationBloc(
//            GoHomeRepo(), DiscoverRepo(), FindRepo(), MessageRepo()),
//        child: AppScreen(widget.onMenuTap),
//      ),
//    );
//  }
//}

///////
class HomeDas extends StatefulWidget with NavigationStates {
  final Function onMenuTap;

  const HomeDas(this.onMenuTap);

  @override
  _HomeDasState createState() => _HomeDasState();
}

class _HomeDasState extends State<HomeDas> {
//  List<String> image = [
//    "https://media.gettyimages.com/photos/hotel-room-in-the-new-hotel-complex-in-moscow-picture-id871617622?s=612x612",
//    "https://q-cf.bstatic.com/images/hotel/max1024x768/222/222713113.jpg",
//    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQFHRtq_SQrHD4AepHJ79JGIa_rPg5uTj_wkw&usqp=CAU",
//    "https://pix10.agoda.net/hotelImages/816/8162470/8162470_19062319400076757869.jpg?s=414x232&ar=16x9"
//  ];

  int currentIndex;

  String ali = 'ali';
  int height = 60;

  RangeValues priceValues = RangeValues(400, 600);
  RangeLabels priceLabels = RangeLabels('400', '600');

  RangeValues sizeValues = RangeValues(400, 600);
  RangeLabels sizeLabels = RangeLabels('400', '600');

  @override
  void initState() {
    // TODO: implement initState
    currentIndex = 0;
    super.initState();
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var localization = AppLocalizations.of(context);
    String name = 'ali';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Moغtrab",
          style: TextStyle(
            color: foregroundColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            size: 30,
            color: foregroundColor,
          ),
          onPressed: widget.onMenuTap,
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: foregroundColor,
              ),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            ali = 'mohamed';
          });
          print("mohab");
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.end,
        opacity: .2,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(
                16)), //border radius doesn't work when the notch is enabled.
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.red,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(
                Icons.near_me,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.near_me,
                color: Colors.deepPurple,
              ),
              title: Text("$ali")),
          BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.search,
                color: Colors.indigo,
              ),
              title: Text("Find")),
          BubbleBottomBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.message,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.message,
                color: Colors.green,
              ),
              title: Text("Messages"))
        ],
      ),
      body: (currentIndex == 0)
          ?
          //GoHome()

          GoHome(size:size, name: name,)
          : (currentIndex == 1)
              // ? Discover()
              ?
              //currentPage
              Find()
              : (currentIndex == 2)
                  ?
                  //currentPage
                  Search()
                  : AllChats(),
    );
  }

  Container search() {
    return Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "property type",
                            style: TextStyle(
                                fontSize: 24, fontFamily: 'VarelaRound'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  color: Colors.indigo,
                                  child: Text('Any'),
                                  onPressed: () {}),
                              RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  color: Colors.grey,
                                  child: Text('House'),
                                  onPressed: () {}),
                              RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  color: Colors.grey,
                                  child: Text('flat'),
                                  onPressed: () {}),
                              RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  color: Colors.grey,
                                  child: Text('Room'),
                                  onPressed: () {})
                            ],
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Price daily",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'VarelaRound')),
                                    Text(
                                        "${priceValues.start.round()}\$ - ${priceValues.end.round()}\$",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'VarelaRound')),
                                  ],
                                ),
                                RangeSlider(
                                  min: 100,
                                  max: 1000,
                                  divisions: 9000,
                                  values: priceValues,
                                  labels: priceLabels,
                                  onChanged: (value) {
                                    setState(() {
                                      priceValues = value;
                                      priceLabels = RangeLabels(
                                          '${value.start.toInt().toString()}\$',
                                          '${value.end.toInt().toString()}\$');
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Property Size",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'VarelaRound')),
                                    Text(
                                        "${sizeValues.start.round()}m - ${sizeValues.end.round()}m",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'VarelaRound')),
                                  ],
                                ),
                                RangeSlider(
                                  min: 100,
                                  max: 1000,
                                  divisions: 9000,
                                  values: sizeValues,
                                  labels: sizeLabels,
                                  onChanged: (value) {
                                    setState(() {
                                      sizeValues = value;
                                      sizeLabels = RangeLabels(
                                          '${value.start.toInt().toString()}\$',
                                          '${value.end.toInt().toString()}\$');
                                    });
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
  }

//  Container find() {
//    return Container(
//                width: 200,
//                height: 200,
//                child: Slider(
//                    value: height.toDouble(),
//                    min: 0,
//                    max: 220,
//                    onChanged: (double newValue) {
//                      setState(() {
//                        height = newValue.round();
//                      });
//                    }),
//              );
//  }

//  Container GoHome(Size size, String name) {
//    return Container(
//            color: Colors.white70,
//            child: ListView.builder(
//              padding: EdgeInsets.all(4),
//              shrinkWrap: true,
//              itemCount: 3,
//              itemBuilder: (context, index) => Padding(
//                padding: EdgeInsets.all(5),
//                child: AspectRatio(
//                  aspectRatio: 0.8,
//                  child: GestureDetector(
//                    onTap: () {
//                      print('home');
//                    },
//                    child: Container(
//                      decoration: BoxDecoration(
//                          color: Colors.blueGrey.withOpacity(0.2),
//                          borderRadius: BorderRadius.circular(30)),
//                      child: Padding(
//                        padding: EdgeInsets.all(6),
//                        child: Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: [
//                              Row(
//                                children: [
//                                  AvatarWidget(
//                                      radius: 20,
//                                      image: NetworkImage(
//                                          'https://greendestinations.org/wp-content/uploads/2019/05/avatar-exemple.jpg')
//                                      //AssetImage('images/person.png')
//                                      // CachedNetworkImageProvider('https://greendestinations.org/wp-content/uploads/2019/05/avatar-exemple.jpg'),
//                                      ),
//                                  SizedBox(width: size.width * .03),
//                                  Column(
//                                    crossAxisAlignment:
//                                        CrossAxisAlignment.start,
//                                    children: [
//                                      Text('$name',
//                                          style: TextStyle(
//                                              color: color1, fontSize: 18)),
//                                      SizedBox(height: size.height * .007),
//                                      Text('since 2m',
//                                          style: TextStyle(
//                                              color: color1, fontSize: 15)),
//                                    ],
//                                  ),
//                                  Expanded(child: SizedBox()),
//                                  IconButton(
//                                    icon: Icon(Icons.favorite_border),
//                                    onPressed: () {
//                                      setState(() {
//                                        name = 'hussen';
//                                      });
//                                      print('object');
//                                    },
//                                  )
//                                ],
//                              ),
//                              Divider(
//                                color: color1,
//                                endIndent: size.width * .2,
//                                indent: size.width * .2,
//                              ),
//                              Padding(
//                                padding:
//                                    const EdgeInsets.symmetric(vertical: 8),
//                                child: Text(
//                                  "Spaical Room",
//                                  style: TextStyle(fontSize: 25),
//                                ),
//                              ),
//                              Expanded(
//                                child: Row(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceAround,
//                                  children: <Widget>[
//                                    Expanded(
//                                      child: Column(
//                                        crossAxisAlignment:
//                                            CrossAxisAlignment.start,
//                                        mainAxisAlignment:
//                                            MainAxisAlignment.spaceAround,
//                                        children: <Widget>[
//                                          Row(
//                                            children: <Widget>[
//                                              Icon(
//                                                FontAwesomeIcons.mapMarkerAlt,
//                                                size: 20,
//                                              ),
//                                              SizedBox(width: 5),
//                                              Text(
//                                                "Cairo",
//                                                style:
//                                                    TextStyle(fontSize: 18),
//                                              )
//                                            ],
//                                          ),
//                                          Row(
//                                            children: <Widget>[
//                                              Icon(
//                                                FontAwesomeIcons.building,
//                                                size: 20,
//                                              ),
//                                              SizedBox(width: 5),
//                                              Text(
//                                                "room(2)",
//                                                style:
//                                                    TextStyle(fontSize: 18),
//                                              )
//                                            ],
//                                          ),
//                                          Row(
//                                            children: <Widget>[
//                                              Icon(
//                                                FontAwesomeIcons.squarespace,
//                                                size: 20,
//                                              ),
//                                              SizedBox(width: 5),
//                                              Text(
//                                                "100M",
//                                                style:
//                                                    TextStyle(fontSize: 18),
//                                              )
//                                            ],
//                                          ),
//                                          RatingBar(
//                                            initialRating: 3,
//                                            minRating: 1,
//                                            direction: Axis.horizontal,
//                                            allowHalfRating: true,
//                                            itemCount: 5,
//                                            itemSize: 20,
//                                            itemPadding: EdgeInsets.symmetric(
//                                                horizontal: 2.0),
//                                            itemBuilder: (context, _) => Icon(
//                                              Icons.star,
//                                              color: Colors.amber,
//                                              size: 10,
//                                            ),
//                                            onRatingUpdate: (rating) {
//                                              print(rating);
//                                            },
//                                          ),
//                                          Text(' 80 review'),
//                                        ],
//                                      ),
//                                    ),
//                                    Expanded(
//                                      child: Column(
//                                        children: <Widget>[
//                                          Text('price',
//                                              style: TextStyle(fontSize: 20)),
//                                          Text('200\$',
//                                              style: TextStyle(fontSize: 30)),
//                                          RaisedButton(
//                                            shape: RoundedRectangleBorder(
//                                              borderRadius:
//                                                  BorderRadius.circular(20),
//                                            ),
//                                            color: Colors.indigo,
//                                            onPressed: () {
//                                              print('object');
//                                            },
//                                            child: Text('Book'),
//                                          )
//                                        ],
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                              Expanded(
//                                child: Padding(
//                                  padding: const EdgeInsets.symmetric(
//                                      vertical: 10),
//                                  child: SizedBox(
//                                    height: 150,
//                                    child: ListView.builder(
//                                      shrinkWrap: true,
//                                      scrollDirection: Axis.horizontal,
//                                      physics: ClampingScrollPhysics(),
//                                      itemCount: image.length,
//                                      itemBuilder: (context, index) =>
//                                          imageFlatWidget(
//                                        image: NetworkImage(image[index]),
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.symmetric(
//                                    horizontal: 15, vertical: 5),
//                                child: Row(
//                                  children: <Widget>[
//                                    AvatarWidget(
//                                        radius: 20,
//                                        image: NetworkImage(
//                                            'https://greendestinations.org/wp-content/uploads/2019/05/avatar-exemple.jpg')
//                                        //AssetImage('images/person.png')
//                                        // CachedNetworkImageProvider('https://greendestinations.org/wp-content/uploads/2019/05/avatar-exemple.jpg'),
//                                        ),
//                                    SizedBox(
//                                      width: 5,
//                                    ),
//                                    Expanded(
//                                      child: TextField(
//                                        textAlign: TextAlign.center,
//                                        decoration:
//                                            KTextFieldDecoration.copyWith(
//                                          hintText: "Comment",
//                                        ),
//                                      ),
//                                    ),
//                                    IconButton(
//                                        icon: Icon(
//                                          Icons.send,
//                                          color: Colors.blueAccent,
//                                        ),
//                                        onPressed: () {})
//                                  ],
//                                ),
//                              )
//                            ]),
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          );
//  }
}
