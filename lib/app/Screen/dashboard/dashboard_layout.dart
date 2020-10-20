import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/about.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/connect_us.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/home1.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/home_board.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/menu.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/my_property.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/profile.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/reservation.dart';
import 'package:mo8tarib/app/bloc/navigation_bloc.dart';

class DashBoardLayout extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoardLayout>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  Duration duration = Duration(milliseconds: 400);
  AnimationController controller;
  Animation<double> scaleAnimation;
  Animation<double> menuScaleAnimation;
  Animation<Offset> slideAnimation;

  //BorderRadiusGeometry borderRadius;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: duration);
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(controller);
    menuScaleAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
    slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(controller);
    // borderRadius = BorderRadius.circular(0);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onMenuTap() {
    setState(() {
      if (isCollapsed)
        controller.forward();
      else
        controller.reverse();
      isCollapsed = !isCollapsed;
      // borderRadius = BorderRadius.circular(40);
    });
  }

  void onMenuItemClicked() {
    setState(() {
      controller.reverse();
    });

    isCollapsed = !isCollapsed;
    // borderRadius = BorderRadius.circular(0);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    return BlocProvider(
      create: (context) => NavigationBloc(onMenuTap),
      child: Material(
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, NavigationStates navigationState) {
                return Menu(menuScaleAnimation, slideAnimation,
                    findSelectedIndex(navigationState), onMenuItemClicked);
              },
            ),
            HomeBoard(
              duration: duration,
              controller: controller,
              isCollapsed: isCollapsed,
              onMenuTap: onMenuTap,
              scaleAnimation: scaleAnimation,
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              // borderRadius: borderRadius,
              child: BlocBuilder<NavigationBloc, NavigationStates>(builder: (
                context,
                NavigationStates navigationState,
              ) {
                return navigationState as Widget;
              }),
            ),
          ],
        ),
      ),
    );
  }
}

int findSelectedIndex(NavigationStates navigationState) {
  if (navigationState is HomeDas) {
    return 0;
  } else if (navigationState is Profile) {
    return 1;
  } else if (navigationState is MyProperty) {
    return 2;
  } else if (navigationState is Reservation) {
    return 3;
  } else if (navigationState is About) {
    return 4;
  } else if (navigationState is ConnectUs) {
    return 5;
  } else {
    return 0;
  }
}
