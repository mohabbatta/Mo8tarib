import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mo8tarib/app/Screen/dashboard/carousel_with_indecator.dart';
import 'package:mo8tarib/app/Screen/location_flat.dart';
import 'package:mo8tarib/app/Screen/property/property_model.dart';
import 'package:mo8tarib/app/Screen/rent.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/app/common_widgets/avatar.dart';
import 'package:mo8tarib/app/common_widgets/message_bubble.dart';
import 'package:mo8tarib/app/common_widgets/search_components.dart';
import 'package:mo8tarib/global.dart';

class PostDetails extends StatefulWidget {
  final Property property;
  final User user;
  const PostDetails({Key key, this.property, this.user}) : super(key: key);

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    CarouselWithIndicatorDemo(
                        imgList:
                            widget.property.imageUrls.cast<String>().toList()),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                            child: Avatar(
                                radius: 20, photoUrl: widget.user.photoUrl),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(widget.user.disPlayName,
                                    style:
                                        TextStyle(color: color1, fontSize: 18)),
                                Text('Owner',
                                    style:
                                        TextStyle(color: color1, fontSize: 18)),
                              ],
                            ),
                          ),
                          Text('\$',
                              style: TextStyle(
                                  fontFamily: 'VarelaRound', fontSize: 30)),
                          Text(widget.property.price.toString(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
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
                                          widget.property.address,
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
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LocationFlat(
                                              docId: widget.property.pid,
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
                                  Icon(FontAwesomeIcons.squarespace, size: 20),
                                  //SizedBox(width: 15),
                                  Text(widget.property.size,
                                      style: TextStyle(fontSize: 18)),
                                  Icon(FontAwesomeIcons.user, size: 20),
                                  //SizedBox(width: 15),
                                  Text(widget.property.gender,
                                      style: TextStyle(fontSize: 18))
                                ]),
                            // SizedBox(height: 10),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                child: Text('Describtion',
                                    style: TextStyle(
                                        fontFamily: 'VarelaRound',
                                        fontSize: 22))),
                            Text(widget.property.description),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: Text('Property Type',
                                        style: TextStyle(
                                            fontFamily: 'VarelaRound',
                                            fontSize: 22))),
                                Text(widget.property.type,
                                    style: TextStyle(
                                        fontFamily: 'VarelaRound',
                                        fontSize: 20,
                                        color: foregroundColor)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: Text('Property Category',
                                        style: TextStyle(
                                            fontFamily: 'VarelaRound',
                                            fontSize: 22))),
                                Text(widget.property.category,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('From'),
//                              Text(flatDocument['timestart'],
//                                  style: TextStyle(
//                                      fontSize: 20, fontFamily: 'VarelaRound')),
                                SizedBox(
                                  height: 15,
                                ),
                                Text('To'),
//                              Text(flatDocument['timeend'],
//                                  style: TextStyle(
//                                      fontSize: 20, fontFamily: 'VarelaRound')),
                              ],
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
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
                                ]),
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
                                  Avatar(
                                    radius: 20,
                                    photoUrl: widget.user.photoUrl,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      decoration: KTextFieldDecoration.copyWith(
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
          _button(),
        ],
      ),
    );
  }

  Widget _button() {
    return Align(
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
                          flatDocId: widget.property.pid,
                          userDocId: widget.property.uid,
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
