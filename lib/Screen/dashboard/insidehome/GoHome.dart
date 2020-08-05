import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mo8tarib/component/allHomeComponent/AvatarWidget.dart';
import 'package:mo8tarib/component/allHomeComponent/imageFlatWidget.dart';

import '../../../global.dart';
import '../../../localization.dart';


class GoHome extends StatefulWidget {
  final Size size;
  final String name;

  const GoHome( {Key key, this.size,this.name}) : super(key: key);
  @override
  _GoHomeState createState() => _GoHomeState();
}

class _GoHomeState extends State<GoHome> {

  List<String> image = [
    "https://media.gettyimages.com/photos/hotel-room-in-the-new-hotel-complex-in-moscow-picture-id871617622?s=612x612",
    "https://q-cf.bstatic.com/images/hotel/max1024x768/222/222713113.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQFHRtq_SQrHD4AepHJ79JGIa_rPg5uTj_wkw&usqp=CAU",
    "https://pix10.agoda.net/hotelImages/816/8162470/8162470_19062319400076757869.jpg?s=414x232&ar=16x9"
  ];

  int height = 100;
  String name;
  var size;
  @override
  void initState() {
    super.initState();
    name=widget.name;
    size=widget.size;
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      color: Colors.white70,
      child: ListView.builder(
        padding: EdgeInsets.all(4),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.all(5),
          child: AspectRatio(
            aspectRatio: 0.8,
            child: GestureDetector(
              onTap: () {
                print('home');
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
                            AvatarWidget(
                                radius: 20,
                                image: NetworkImage(
                                    'https://greendestinations.org/wp-content/uploads/2019/05/avatar-exemple.jpg')
                              //AssetImage('images/person.png')
                              // CachedNetworkImageProvider('https://greendestinations.org/wp-content/uploads/2019/05/avatar-exemple.jpg'),
                            ),
                            SizedBox(width: size.width * .03),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text('$name',
                                    style: TextStyle(
                                        color: color1, fontSize: 18)),
                                SizedBox(height: size.height * .007),
                                Text('since 2m',
                                    style: TextStyle(
                                        color: color1, fontSize: 15)),
                              ],
                            ),
                            Expanded(child: SizedBox()),
                            IconButton(
                              icon: Icon(Icons.favorite_border),
                              onPressed: () {
                                setState(() {
                                  name = 'hussen';
                                });
                                print('object');
                              },
                            )
                          ],
                        ),
                        Divider(
                          color: color1,
                          endIndent: size.width * .2,
                          indent: size.width * .2,
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Spaical Room",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.mapMarkerAlt,
                                          size: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "Cairo",
                                          style:
                                          TextStyle(fontSize: 18),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.building,
                                          size: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "room(2)",
                                          style:
                                          TextStyle(fontSize: 18),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.squarespace,
                                          size: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "100M",
                                          style:
                                          TextStyle(fontSize: 18),
                                        )
                                      ],
                                    ),
                                    RatingBar(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 20,
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
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text('price',
                                        style: TextStyle(fontSize: 20)),
                                    Text('200\$',
                                        style: TextStyle(fontSize: 30)),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(20),
                                      ),
                                      color: Colors.indigo,
                                      onPressed: () {
                                        print('object');
                                      },
                                      child: Text('Book'),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10),
                            child: SizedBox(
                              height: 150,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: ClampingScrollPhysics(),
                                itemCount: image.length,
                                itemBuilder: (context, index) =>
                                    imageFlatWidget(
                                      image: NetworkImage(image[index]),
                                    ),
                              ),
                            ),
                          ),
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
                        )
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }

}
