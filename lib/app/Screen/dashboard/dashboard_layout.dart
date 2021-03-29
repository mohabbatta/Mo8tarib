import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo8tarib/app/Screen/dashboard/home_layout/home_layout.dart';
import 'package:mo8tarib/app/Screen/dashboard/menu_dashboard_layout.dart';
import 'package:mo8tarib/app/Screen/dashboard/about_us/about_us.dart';
import 'package:mo8tarib/app/Screen/dashboard/connect_us/connect_us.dart';
import 'package:mo8tarib/app/Screen/dashboard/menu.dart';
import 'package:mo8tarib/app/Screen/dashboard/property/my_property.dart';
import 'package:mo8tarib/app/Screen/dashboard/profile/profile.dart';
import 'package:mo8tarib/app/Screen/dashboard/rservation/reservation.dart';
import 'package:mo8tarib/app/Screen/dashboard/settings/setting_page.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/app/bloc/navigation_bloc.dart';
import 'package:mo8tarib/services/app_language.dart';
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
  Animation<Offset> rightSlideAnimation;
  Animation<Offset> leftSlideAnimation;
  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: duration);
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(controller);
    menuScaleAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
    rightSlideAnimation = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
        .animate(controller);
    leftSlideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
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
    var appLanguage = Provider.of<AppLanguage>(context);
    var slide = appLanguage.appLocal.languageCode == "en"
        ? leftSlideAnimation
        : rightSlideAnimation;
    return StreamBuilder<MyUser>(
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
                          slide,
                          findSelectedIndex(navigationState),
                          onMenuItemClicked,
                          user);
                    },
                  ),
                  Provider<MyUser>.value(
                    value: user,
                    child: MenuDashBoardLayout(
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
  if (navigationState is HomeLayout) {
    return 0;
  } else if (navigationState is Profile) {
    return 1;
  } else if (navigationState is MyProperty) {
    return 2;
  } else if (navigationState is Reservation) {
    return 3;
  } else if (navigationState is SettingPage) {
    return 4;
  } else if (navigationState is AboutUs) {
    return 5;
  } else if (navigationState is ConnectUs) {
    return 6;
  } else {
    return 0;
  }
}
