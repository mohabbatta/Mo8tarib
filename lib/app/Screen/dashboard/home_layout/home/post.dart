import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mo8tarib/app/Screen/dashboard/home_layout/home/post_details.dart';
import 'package:mo8tarib/app/Screen/dashboard/home_layout/home/rent.dart';
import 'package:mo8tarib/app/Screen/dashboard/property/property_model.dart';
import 'package:mo8tarib/app/common_widgets/carousel_with_indecator.dart';
import 'package:mo8tarib/app/Screen/dashboard/profile/post_model.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/app/common_widgets/avatar.dart';
import 'package:mo8tarib/constants/global.dart';
import 'package:mo8tarib/services/data_base.dart';
import 'package:provider/provider.dart';

class Post extends StatefulWidget {
  final PostModel postModel;
  final Property property;
  final MyUser user;

  const Post({Key key, this.property, this.user, this.postModel})
      : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  bool like = false;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    final user = Provider.of<MyUser>(context);
    return AspectRatio(
        aspectRatio: 0.8,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetails(
                    property: widget.property,
                    user: widget.user,
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
                        Avatar(
                          radius: 20,
                          photoUrl: widget.user.photoUrl,
                        ),
                        //  SizedBox(width: size.width * .03),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${widget.user.disPlayName}',
                                  style:
                                      TextStyle(color: color1, fontSize: 18)),
                              Text(
                                  Jiffy(widget.postModel.time.toDate())
                                      .fromNow(),

                                  // 'since ${new DateFormat.yMMMd().format(postModel.time.toDate())}  m',
                                  style:
                                      TextStyle(color: color1, fontSize: 15)),
                            ],
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        IconButton(
                          icon: like
                              ? Icon(Icons.favorite)
                              : Icon(Icons.favorite_border),
                          onPressed: () async {
                            setState(() {
                              like = !like;
                            });
                            if (like) {
                              await database.addLike(
                                  userId: user.uid,
                                  postId: widget.postModel.postId);
                            } else {
                              await database.removeLike(
                                  userId: user.uid,
                                  postId: widget.postModel.postId);
                            }
                          },
                        )
                      ],
                    ),
                    Divider(color: color1),
                    Expanded(
                      flex: 2,
                      child: CarouselWithIndicatorDemo(
                          imgList: widget.property.imageUrls
                              .cast<String>()
                              .toList()),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        "${widget.property.category}",
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
                                        "${widget.property.address}",
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
                                      "${widget.property.size}M",
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                                RatingBar.builder(
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
                                Text('${widget.property.price.toString()}\$',
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
                                            flatDocId: widget.postModel.flatId,
                                            userDocId: widget.postModel.userId,
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
