import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/GoHome.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/chat/chat_rooms.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/map_marker.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/search.dart';
import 'package:mo8tarib/app/bloc/navigation_bloc.dart';
import 'package:mo8tarib/global.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

class HomeDas extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  const HomeDas(this.onMenuTap);

  @override
  _HomeDasState createState() => _HomeDasState();
}

class _HomeDasState extends State<HomeDas> {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("Moغtrab", style: TextStyle(color: foregroundColor)),
        leading: IconButton(
          icon: Icon(Icons.menu, size: 30, color: foregroundColor),
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
              title: Text("Discover")),
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
              title: Text("Search")),
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
          ? GoHome.create(context)
          // ? GoHome()
          : (currentIndex == 1)
              ? MapMarker()
              : (currentIndex == 2)
                  ? Search()
                  : ChatRooms.create(context),
    );
  }
}
