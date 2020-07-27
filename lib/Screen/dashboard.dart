import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/global.dart';
import 'package:mo8tarib/localization.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    return Stack(
      children: <Widget>[
        menu(context),
        dashboard(context),
      ],
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.4 * screenWidth,
      right: isCollapsed ? 0 : -0.4 * screenWidth,
      duration: duration,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundColor2,
            centerTitle: true,
            title: Text(
              "Moغtrab",
              style: TextStyle(
                color: foregroundColor,
              ),
            ),
            leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 30,
                  color: foregroundColor,
                ),
                onPressed: () {
                  setState(() {
                    if (isCollapsed)
                      controller.forward();
                    else
                      controller.reverse();
                    isCollapsed = !isCollapsed;
                  });
                }),
          ),
          backgroundColor: backgroundColor2,
        ),
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: slideAnimation,
      child: ScaleTransition(
        scale: menuScaleAnimation,
        child: Container(
          color: backgroundColor1,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage("images/avater.png"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  menuItem(name: "DashBoard", function: () {}),
                  SizedBox(height: 10),
                  menuItem(name: "profile", function: () {}),
                  SizedBox(height: 10),
                  menuItem(name: "Flat", function: () {}),
                  SizedBox(height: 10),
                  menuItem(name: "Reservation", function: () {}),
                  SizedBox(height: 10),
                  menuItem(name: "about", function: () {}),
                  SizedBox(height: 10),
                  menuItem(name: "connect Us", function: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class menuItem extends StatelessWidget {
  menuItem({@required this.name, this.function});
  String name;
  Function function;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () {},
      child: Text(
        localization.translate(name),
        style: TextStyle(
            color: foregroundColor,
            fontSize: 20,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
