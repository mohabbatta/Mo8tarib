import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:mo8tarib/bloc/navigation_bloc.dart';
import 'package:mo8tarib/component/allHomeComponent/imageFlatWidget.dart';
import 'package:mo8tarib/global.dart';


class Profile extends StatefulWidget with NavigationStates{
  final Function onMenuTap;

  const Profile(this.onMenuTap);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  List<String> image = [
    "https://media.gettyimages.com/photos/hotel-room-in-the-new-hotel-complex-in-moscow-picture-id871617622?s=612x612",
    "https://q-cf.bstatic.com/images/hotel/max1024x768/222/222713113.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQFHRtq_SQrHD4AepHJ79JGIa_rPg5uTj_wkw&usqp=CAU",
    "https://pix10.agoda.net/hotelImages/816/8162470/8162470_19062319400076757869.jpg?s=414x232&ar=16x9"
  ];

  double get randHeight => Random().nextInt(100).toDouble();

  List<Widget> _randomChildren;

  // Children with random heights - You can build your widgets of unknown heights here
  // I'm just passing the context in case if any widgets built here needs  access to context based data like Theme or MediaQuery
  List<Widget> _randomHeightWidgets(BuildContext context) {
    _randomChildren ??= List.generate(3, (index) {
      final height = randHeight.clamp(
        50.0,
        MediaQuery.of(context).size.width, // simply using MediaQuery to demonstrate usage of context
      );
      return Container(
        color: Colors.primaries[index],
        height: height,
        child: Text('Random Height Child ${index + 1}'),
      );
    });

    return _randomChildren;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Persistent AppBar that never scrolls
      body:
      DefaultTabController(
        length: 2,
        child: NestedScrollView(
          // allows you to build a list of elements that would be scrolled away till the body reached the top
        headerSliverBuilder: (context, _){
          return[
            SliverAppBar(
                flexibleSpace: FlexibleSpaceBar(

                  title:Text('Profile', style: TextStyle(color: color2)),
                  centerTitle: true,

                ),
                expandedHeight:150,
                pinned: true,
                //floating: true,
                backgroundColor: color1,
                elevation: 5,

           )
//          SliverPersistentHeader(
//            pinned: true,
//            delegate: ,
//
//          )
          ];
          },

          // You tab view goes here
          body: Column(
            children: <Widget>[
              HeaderSection(),
              TabBar(
                indicatorColor: color1,

                tabs: [
                  Tab(

                      child:
                  Text('All Flat', style: TextStyle(color: color2))
                  ),
                  Tab(
                      child: Text('Posts Save', style: TextStyle(color: color2))
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    GridView.count(
                      padding: EdgeInsets.zero,
                      crossAxisCount: 3,
                      children:<Widget>[
                        for(int i=0;i<image.length;i++)
                          imageFlatWidget(
                            image: NetworkImage(image[i]),
                          ),

                        ]
                    ),
                    GridView.count(
                        padding: EdgeInsets.zero,
                        crossAxisCount: 3,
                        children:<Widget>[
                          for(int i=0;i<image.length;i++)
                            imageFlatWidget(
                              image: NetworkImage(image[i]),
                            ),

                        ]
                    )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
class HeaderSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color1,
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(image: AssetImage('images/avater.png'), fit: BoxFit.cover),
            ),
          ),
          SizedBox(height:5),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Tata',
              textAlign: TextAlign.center,
              style: TextStyle(color: color2,fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
          SizedBox(height:2),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Text(
              'FCI',
              textAlign: TextAlign.center,
                style: TextStyle(color: color2)
            ),
          ),
          SizedBox(height: 5),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Padding(

              padding: EdgeInsets.only(left: 60,right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        '4',
                        style: TextStyle(color: color2,fontWeight: FontWeight.w600),
                      ),
                      Text('Flat',
                        style: TextStyle(color: color2)
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '4',
                        style: TextStyle(color: color2,fontWeight: FontWeight.w600),
                      ),
                      Text('Saved',
                        style: TextStyle(color: color2)
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

}
