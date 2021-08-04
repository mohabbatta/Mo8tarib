import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/constants/color_constants.dart';
import 'package:mo8tarib/constants/global.dart';

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final Function press;
  final bool isActive;

  const BottomNavItem({
    Key key,
    @required this.size, this.icon, this.press, this.isActive=false,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            icon,
            color: isActive?ColorConstants.primaryColor:Colors.white,
            size: size.height*.05,
          ),
//                Text('Home',style: TextStyle(color: color2,fontSize:size.height*.01 )),
        ],
      ),
    );
  }
}