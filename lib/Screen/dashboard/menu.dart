import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:mo8tarib/bloc/navigation_bloc.dart';
import 'package:mo8tarib/component/menu_item.dart';
import '../../global.dart';

class Menu extends StatefulWidget {
  final Animation<double> menuScaleAnimation;
  final Animation<Offset> slideAnimation;
  final int selectedIndex;
  final Function onMenuItemClicked;

  Menu(this.menuScaleAnimation, this.slideAnimation, this.selectedIndex,
      this.onMenuItemClicked);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  FirebaseUser loggedInUser;
  final _fireStore = Firestore.instance;

  String url;
  String firstNameText;
  String lastNameText;
  File image;
  Map<String, dynamic> map1 = {'first': 'ali', 'mid': 'ali', 'last': 'ali'};

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();

      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        getData();
      }
    } catch (e) {
      print("error in menu");
    }
  }

  void getData() async {
    _fireStore
        .collection('user')
        .where("email", isEqualTo: loggedInUser.email)
        .snapshots()
        .listen((data) => data.documents.forEach((doc) {
              setState(() {
                url = doc['url'];
                map1 = doc['name'];
                firstNameText = map1['first'];
                lastNameText = map1['last'];

                print(url);
                print(map1['first']);
                print(map1['last']);
              });

              loadImage(url);
            }));
  }

  void loadImage(String url1) async {
    var imageId = await ImageDownloader.downloadImage(url1);
    var path = await ImageDownloader.findPath(imageId);
    File image1 = File(path);
    setState(() {
      image = image1;
    });
  }

  Future<void> googleSignOut() async {
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
    });
  }

  @override
  void initState() {
    getCurrentUser();
//    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: widget.slideAnimation,
      child: ScaleTransition(
        scale: widget.menuScaleAnimation,
        child: Container(
          color: Colors.black.withOpacity(0.9),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Align(
              // alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 15, left: 15),
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage:
                                  image == null ? null : FileImage(image),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "$firstNameText $lastNameText",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 20,
                                fontFamily: "VarelaRound",
                                fontWeight: FontWeight.normal,
                                color: foregroundColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/edituser');
                              },
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 16,
                                  fontFamily: "VarelaRound",
                                  fontWeight: FontWeight.normal,
                                  color: foregroundColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      MenuItem(
                        itemName: "Home",
                        function: () {
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.DashBoardClickEvent);
                          widget.onMenuItemClicked();
                        },
                        fontWeight: widget.selectedIndex == 0
                            ? FontWeight.w900
                            : FontWeight.normal,
                        icon: Icons.home,
                      ),
                      SizedBox(height: 10),
                      MenuItem(
                        itemName: "profile",
                        function: () {
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.ProfileClickEvent);
                          widget.onMenuItemClicked();
                        },
                        fontWeight: widget.selectedIndex == 1
                            ? FontWeight.w900
                            : FontWeight.normal,
                        icon: Icons.person,
                      ),
                      SizedBox(height: 10),
                      MenuItem(
                        itemName: "My Property",
                        function: () {
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.FlatClickEvent);
                          widget.onMenuItemClicked();
                        },
                        fontWeight: widget.selectedIndex == 2
                            ? FontWeight.w900
                            : FontWeight.normal,
                        icon: Icons.room,
                      ),
                      SizedBox(height: 10),
                      MenuItem(
                        itemName: "Reservation",
                        function: () {
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.ReservationClickEvent);
                          widget.onMenuItemClicked();
                        },
                        fontWeight: widget.selectedIndex == 3
                            ? FontWeight.w900
                            : FontWeight.normal,
                        icon: Icons.phone_in_talk,
                      ),
                      SizedBox(height: 10),
                      MenuItem(
                        itemName: "about",
                        function: () {
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.AboutClickEvent);
                          widget.onMenuItemClicked();
                        },
                        fontWeight: widget.selectedIndex == 4
                            ? FontWeight.w900
                            : FontWeight.normal,
                        icon: Icons.help,
                      ),
                      SizedBox(height: 10),
                      MenuItem(
                        itemName: "connect Us",
                        function: () {
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.ConnectUsEvent);
                          widget.onMenuItemClicked();
                        },
                        fontWeight: widget.selectedIndex == 5
                            ? FontWeight.w900
                            : FontWeight.normal,
                        icon: Icons.contact_mail,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: MenuItem(
                      itemName: "LogOut",
                      icon: Icons.power_settings_new,
                      function: () {
                        print("out");
                        googleSignOut();
                        print("googleout");
                        _auth.signOut();
                        print("fireout");
                        Navigator.pushNamed(context, '/');
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
