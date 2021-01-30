import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mo8tarib/app/Screen/dashboard/carousel_with_indecator.dart';
import 'package:mo8tarib/app/Screen/location_flat.dart';
import 'package:mo8tarib/app/Screen/property/property_model.dart';
import 'package:mo8tarib/app/Screen/rent.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/app/common_widgets/avatar.dart';
import 'package:mo8tarib/app/common_widgets/search_components.dart';
import 'package:mo8tarib/global.dart';

class PostDetails extends StatefulWidget {
  final Property property;
  final MyUser user;
  const PostDetails({Key key, this.property, this.user}) : super(key: key);

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 32,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              iconTheme: IconThemeData(
                color: foregroundColor,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: IconButton(
                    icon: Icon(Icons.favorite_border),
                    iconSize: 34,
                    onPressed: () {},
                  ),
                ),
              ],
              backgroundColor: Colors.white,
              pinned: false,
              floating: true,
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CarouselWithIndicatorDemo(
                      imgList:
                          widget.property.imageUrls.cast<String>().toList()),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
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
                                      style: TextStyle(
                                          color: color1, fontSize: 18)),
                                  Text('Owner',
                                      style: TextStyle(
                                          color: color1, fontSize: 18)),
                                ],
                              ),
                            ),
                            Text(widget.property.price.toString(),
                                style: TextStyle(
                                    fontFamily: 'VarelaRound', fontSize: 30)),
                            Text('EGP',
                                style: TextStyle(
                                    fontFamily: 'VarelaRound', fontSize: 20)),
                            Text('/day',
                                style: TextStyle(
                                    fontFamily: 'VarelaRound', fontSize: 20))
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              size: 25,
                              color: foregroundColor,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  widget.property.address,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
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
                        SizedBox(height: 14),
                        Row(children: <Widget>[
                          _item(Icon(FontAwesomeIcons.hotel, size: 20),
                              widget.property.type),
                          _item(Icon(FontAwesomeIcons.swimmer, size: 20),
                              widget.property.category),
                          _item(Icon(FontAwesomeIcons.squarespace, size: 20),
                              widget.property.size),
                        ]),
                        Row(children: <Widget>[
                          _item(Icon(FontAwesomeIcons.bed, size: 20),
                              widget.property.gender),
                          _item(Icon(FontAwesomeIcons.bath, size: 20),
                              widget.property.gender),
                          _item(Icon(FontAwesomeIcons.user, size: 20),
                              widget.property.gender),
                        ]),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  child: Text('Describtion',
                                      style: TextStyle(
                                          fontFamily: 'VarelaRound',
                                          fontSize: 22))),
                              Text(widget.property.description),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              Row(
                                children: [
                                  RatingBar.builder(
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
                                ],
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

  Widget _item(Widget key, String value) {
    return Row(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Colors.black12),
                    child: Center(
                      child: key,
                    )),
              ],
            )),
        Text(value,
            style: TextStyle(
                fontFamily: 'VarelaRound',
                fontSize: 18,
                color: foregroundColor)),
      ],
    );
  }
}
