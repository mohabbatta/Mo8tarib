import 'package:flutter/material.dart';
import 'package:mo8tarib/global.dart';
import 'package:mo8tarib/localization.dart';

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
            itemName,
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
