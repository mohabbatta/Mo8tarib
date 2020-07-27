import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo8tarib/bloc/navigation_bloc.dart';
import 'package:mo8tarib/localization.dart';

import '../../global.dart';

class Menu extends StatelessWidget {
  final Animation<double> menuScaleAnimation;
  final Animation<Offset> slideAnimation;
  final int selectedIndex;
  final Function onMenuItemClicked;

  Menu(this.menuScaleAnimation, this.slideAnimation, this.selectedIndex,
      this.onMenuItemClicked);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: ScaleTransition(
        scale: menuScaleAnimation,
        child: Container(
          color: Colors.white.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
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
                          backgroundImage: AssetImage("images/avater.png"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "mohab batta",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontFamily: "VarelaRound",
                            fontWeight: FontWeight.normal,
                            color: foregroundColor,
                          ),
                        ),
                        Text(
                          "Edit Profile",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 16,
                            fontFamily: "VarelaRound",
                            fontWeight: FontWeight.normal,
                            color: foregroundColor,
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
                      onMenuItemClicked();
                    },
                    fontWeight: selectedIndex == 0
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
                      onMenuItemClicked();
                    },
                    fontWeight: selectedIndex == 1
                        ? FontWeight.w900
                        : FontWeight.normal,
                    icon: Icons.person,
                  ),
                  SizedBox(height: 10),
                  MenuItem(
                    itemName: "Flat",
                    function: () {
                      BlocProvider.of<NavigationBloc>(context)
                          .add(NavigationEvents.FlatClickEvent);
                      onMenuItemClicked();
                    },
                    fontWeight: selectedIndex == 2
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
                      onMenuItemClicked();
                    },
                    fontWeight: selectedIndex == 3
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
                      onMenuItemClicked();
                    },
                    fontWeight: selectedIndex == 4
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
                      onMenuItemClicked();
                    },
                    fontWeight: selectedIndex == 5
                        ? FontWeight.w900
                        : FontWeight.normal,
                    icon: Icons.contact_mail,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String itemName;
  final Function function;
  final int index;
  final IconData icon;
  final FontWeight fontWeight;

  MenuItem(
      {@required this.itemName,
      this.function,
      this.index,
      this.fontWeight,
      this.icon});

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return GestureDetector(
      onTap: function,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: foregroundColor,
            size: 25,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            localization.translate(itemName),
            style: TextStyle(
              color: foregroundColor,
              fontSize: 20,
              decoration: TextDecoration.none,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}
