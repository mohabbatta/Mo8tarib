import 'package:flutter/material.dart';
import 'package:mo8tarib/constants/color_constants.dart';
import 'package:mo8tarib/constants/global.dart';

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
    return GestureDetector(
      onTap: function,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: ColorConstants.primaryColor,
            size: 25,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            itemName,
            style: TextStyle(
              color: ColorConstants.primaryColor,
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
