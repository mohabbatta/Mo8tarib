import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/component/allHomeComponent/BottomNavItem.dart';
import 'package:mo8tarib/global.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: size.height * 0.09,
      color: color1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          BottomNavItem(size: size, icon: Icons.home, isActive: true),
          BottomNavItem(size: size, icon: Icons.search),
          BottomNavItem(size: size, icon: Icons.person)
        ],
      ),
    );
  }
}
