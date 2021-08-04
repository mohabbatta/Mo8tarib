import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/app/common_widgets/allHomeComponent/BottomNavItem.dart';
import 'package:mo8tarib/constants/color_constants.dart';
import 'package:mo8tarib/constants/global.dart';

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
      color: ColorConstants.black,
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
