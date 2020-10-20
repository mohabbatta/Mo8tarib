import 'package:flutter/material.dart';
import 'package:mo8tarib/global.dart';

class ReusableEditUser extends StatelessWidget {
  ReusableEditUser(
      {@required this.textFieldName, this.controller, this.getText, this.hint});

  final TextEditingController controller;
  final String textFieldName;
  final String hint;
  final Function getText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        children: <Widget>[
          Text(
            textFieldName,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Flexible(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                onEditingComplete: () {
                  print(controller);
                },
                style: TextStyle(
                  fontSize: 20,
                ),

                controller: controller,

//                textAlign: TextAlign.end,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: TextStyle(color: foregroundColor)),
                onChanged: getText,
              ),
            ),
          )
        ],
      ),
    );
  }
}
