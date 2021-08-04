import 'package:flutter/material.dart';
import 'package:mo8tarib/constants/color_constants.dart';
import 'package:mo8tarib/constants/global.dart';

class CustomDropDown extends StatelessWidget {
  final String nameText;
  final String value;
  final List<String> arrItems;
  final Function getValue;
  const CustomDropDown(
      {Key key, this.nameText, this.value, this.arrItems, this.getValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            nameText,
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'VarelaRound',
            ),
          ),
        ),
        DropdownButton<String>(
          value: value,
          icon: Icon(Icons.arrow_downward),
          iconSize: 20,
          elevation: 16,
          style: TextStyle(
              fontSize: 18, fontFamily: 'VarelaRound', color: Colors.black),
          underline: Container(
            height: 2,
            color: ColorConstants.primaryColor,
          ),
          onChanged: getValue,
          items: arrItems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )
      ],
    );
  }
}
