import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mo8tarib/app/Screen/dashboard/carousel_with_indecator.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/go_home_model.dart';
import 'package:mo8tarib/app/Screen/post_details.dart';
import 'package:mo8tarib/app/Screen/property/property_model.dart';
import 'package:mo8tarib/app/Screen/rent.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/app/common_widgets/avatar.dart';
import 'package:mo8tarib/global.dart';

class Post extends StatelessWidget {
  final GoHomeModel goHomeModel;
  final Property property;
  final User user;

  const Post({Key key, this.goHomeModel, this.property, this.user})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 0.8,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetails(
//                    flatDocId: '${goHomeModel.propertyReference}',
//                    userDocId: '${goHomeModel.userReference}',
                    property: property,
                    user: user,
                  ),
                ));
            print('go to details');
          },
          child: Container(
            decoration: BoxDecoration(
                //  color: Colors.blueGrey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
//                        AvatarWidget(
//                          radius: 20,
//                          image: user.photoUrl,
//                        ),
                        Avatar(
                          radius: 20,
                          photoUrl: user.photoUrl,
                        ),
                        //  SizedBox(width: size.width * .03),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${user.disPlayName}',
                                  style:
                                      TextStyle(color: color1, fontSize: 18)),
                              Text(
                                  'since ${new DateFormat.yMMMd().format(goHomeModel.time.toDate())}  m',
                                  style:
                                      TextStyle(color: color1, fontSize: 15)),
                            ],
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        IconButton(
                          icon: Icon(Icons.favorite_border),
                          onPressed: () {},
                        )
                      ],
                    ),
                    Divider(color: color1),
                    Expanded(
                      flex: 2,
                      child: CarouselWithIndicatorDemo(
                          imgList: property.imageUrls.cast<String>().toList()),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        "${property.category}",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.mapMarkerAlt,
                                      size: 16,
                                    ),
                                    SizedBox(width: 3),
                                    Expanded(
                                      child: Text(
                                        // "Cairo",
                                        "${property.address}",
                                        style: TextStyle(fontSize: 16),
                                      ),
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
                                      // 'tata',
                                      "room)",
                                      style: TextStyle(fontSize: 18),
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
                                      "${property.size}M",
                                      style: TextStyle(fontSize: 18),
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
//                                                              Text(
//                                                                  ' 80 review'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text('price', style: TextStyle(fontSize: 20)),
                                Text('${property.price.toString()}\$',
                                    style: TextStyle(fontSize: 30)),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  color: Colors.indigo,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Rent(
                                            flatDocId:
                                                '${goHomeModel.propertyReference}',
                                            userDocId:
                                                '${goHomeModel.userReference}',
                                          ),
                                        ));
                                  },
                                  child: Text('Rent'),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
