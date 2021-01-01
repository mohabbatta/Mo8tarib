import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/home_board.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/about.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/connect_us.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/home_dash.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/menu.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/my_property.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/profile.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/reservation.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/app/bloc/navigation_bloc.dart';
import 'package:mo8tarib/services/data_base.dart';
import 'package:provider/provider.dart';

class DashBoardLayout extends StatefulWidget {
  final String uid;

  const DashBoardLayout({Key key, this.uid}) : super(key: key);
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
  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: duration);
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(controller);
    menuScaleAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
    slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(controller);
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
    });
  }

  void onMenuItemClicked() {
    setState(() {
      controller.reverse();
    });
    isCollapsed = !isCollapsed;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    final database = Provider.of<Database>(context);
    return StreamBuilder<User>(
        stream: database.userStream(userId: widget.uid),
        builder: (context, snapshot) {
          final user = snapshot.data;
          return BlocProvider(
            create: (context) => NavigationBloc(onMenuTap),
            child: Material(
              child: Stack(
                children: <Widget>[
                  BlocBuilder<NavigationBloc, NavigationStates>(
                    builder: (context, NavigationStates navigationState) {
                      return Menu(
                          menuScaleAnimation,
                          slideAnimation,
                          findSelectedIndex(navigationState),
                          onMenuItemClicked,
                          user);
                    },
                  ),
                  Provider<User>.value(
                    value: user,
                    child: HomeBoard(
                      duration: duration,
                      controller: controller,
                      isCollapsed: isCollapsed,
                      onMenuTap: onMenuTap,
                      scaleAnimation: scaleAnimation,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      child: BlocBuilder<NavigationBloc, NavigationStates>(
                          builder: (context, NavigationStates navigationState) {
                        return navigationState as Widget;
                      }),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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
