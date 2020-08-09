import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mo8tarib/component/allHomeComponent/AvatarWidget.dart';
import 'package:mo8tarib/component/message_bubble.dart';
import 'package:mo8tarib/component/search_components.dart';
import 'package:mo8tarib/global.dart';

class PostDetails extends StatefulWidget {
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  double screenWidth, screenHeight;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    return Material(
      child: Container(
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
                          child: Carousel(
                            boxFit: BoxFit.cover,
                            autoplay: false,
                            animationCurve: Curves.fastOutSlowIn,
                            animationDuration: Duration(milliseconds: 1000),
                            dotSize: 6.0,
                            dotIncreasedColor: foregroundColor,
                            dotBgColor: Colors.transparent,
                            dotPosition: DotPosition.bottomCenter,
                            dotVerticalPadding: 10.0,
                            showIndicator: true,
                            indicatorBgPadding: 7.0,
                            images: [
                              NetworkImage(
                                  'https://media.gettyimages.com/photos/hotel-room-in-the-new-hotel-complex-in-moscow-picture-id871617622?s=612x612'),
                              NetworkImage(
                                  'https://q-cf.bstatic.com/images/hotel/max1024x768/222/222713113.jpg'),
                              NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQFHRtq_SQrHD4AepHJ79JGIa_rPg5uTj_wkw&usqp=CAU'),
                            ],
                          )),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 22, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      icon: Icon(Icons.favorite_border),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.bookmark_border),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                              child: AvatarWidget(
                                  radius: 20,
                                  image: NetworkImage(
                                      'https://greendestinations.org/wp-content/uploads/2019/05/avatar-exemple.jpg')),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('mohab batta',
                                      style: TextStyle(
                                          color: color1, fontSize: 18)),
                                  Text('Owner',
                                      style: TextStyle(
                                          color: color1, fontSize: 18)),
                                ],
                              ),
                            ),
                            Text('\$',
                                style: TextStyle(
                                    fontFamily: 'VarelaRound', fontSize: 30)),
                            Text(' 750 ',
                                style: TextStyle(
                                    fontFamily: 'VarelaRound', fontSize: 30)),
                            Text(' / day',
                                style: TextStyle(
                                    fontFamily: 'VarelaRound', fontSize: 20))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.mapMarkerAlt,
                                          size: 25,
                                          color: foregroundColor,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                            'cairo/nasr',
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
                                          size: 25, color: foregroundColor),
                                      onPressed: () {})
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.bed, size: 20),
                                    //SizedBox(width: 15),
                                    Text("2 bd",
                                        style: TextStyle(fontSize: 18)),
                                    Icon(FontAwesomeIcons.squarespace,
                                        size: 20),
                                    //SizedBox(width: 15),
                                    Text("50 m ",
                                        style: TextStyle(fontSize: 18)),
                                    Icon(FontAwesomeIcons.user, size: 20),
                                    //SizedBox(width: 15),
                                    Text("1-2", style: TextStyle(fontSize: 18))
                                  ]),
                              // SizedBox(height: 10),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  child: Text('Describtion',
                                      style: TextStyle(
                                          fontFamily: 'VarelaRound',
                                          fontSize: 22))),
                              Text('one bed room with araf eh gahaza l ae haga '
                                  'sdvvvfbdbdfbsdffffffvsdf '
                                  'dzbfdbbbzbgg'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      child: Text('Property status',
                                          style: TextStyle(
                                              fontFamily: 'VarelaRound',
                                              fontSize: 22))),
                                  Text('Available',
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
                                  Text('From'),
                                  Text("dd/MM/yyyy",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'VarelaRound')),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text('To'),
                                  Text("dd/MM/yyyy",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'VarelaRound')),
                                ],
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  child: Text('Additions',
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
                                ],
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
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 2.0),
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
                                        image: NetworkImage(
                                            'https://greendestinations.org/wp-content/uploads/2019/05/avatar-exemple.jpg')
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
                                            KTextFieldDecoration.copyWith(
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
                          print('Find');
                        },
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
  }
}

///TODO samy backend for Post in home and Post PostDetails
