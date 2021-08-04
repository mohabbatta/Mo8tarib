import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/home_layout/chat/chat_rooms.dart';
import 'package:mo8tarib/app/Screen/dashboard/home_layout/discover/map_marker.dart';
import 'package:mo8tarib/app/Screen/dashboard/home_layout/home/Home.dart';
import 'package:mo8tarib/app/Screen/dashboard/home_layout/search/search.dart';
import 'package:mo8tarib/app/bloc/navigation_bloc.dart';
import 'package:mo8tarib/constants/color_constants.dart';
import 'package:mo8tarib/constants/global.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:mo8tarib/helper/localization.dart';

class HomeLayout extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  const HomeLayout(this.onMenuTap);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex;
  @override
  void initState() {
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
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate('Mo8tarib'), style: TextStyle(color: ColorConstants.primaryColor)),
        leading: IconButton(
          icon: Icon(Icons.menu, size: 30, color: ColorConstants.primaryColor),
          onPressed: widget.onMenuTap,
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {},
//        child: Icon(Icons.add),
//        backgroundColor: Colors.red,
//      ),
      //   floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true,
        //fabLocation: BubbleBottomBarFabLocation.end,
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
              title: Text(AppLocalizations.of(context).translate('Home'))),
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
              title: Text(AppLocalizations.of(context).translate('Discover'))),
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
              title: Text(AppLocalizations.of(context).translate('Search'))),
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
              title: Text(AppLocalizations.of(context).translate('Messages')))
        ],
        backgroundColor: darkModeOn?Colors.black12:Colors.white  ,
      ),
      body: (currentIndex == 0)
          ? Home.create(context)
          // ? GoHome()
          : (currentIndex == 1)
              ? MapMarker()
              : (currentIndex == 2)
                  ? Search()
                  : ChatRooms.create(context),
    );
  }
}
