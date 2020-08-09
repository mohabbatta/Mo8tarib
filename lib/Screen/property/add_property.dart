import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mo8tarib/global.dart';

class AddProperty extends StatefulWidget {
  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  File get image => null;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CircleAvatar(
                backgroundImage: image == null ? null : FileImage(image),
                radius: 60,
              ),
            ),
            Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: Builder(
                builder: (context) => FlatButton(
                  onPressed: () {},
                  child: Text(
                    "dvsdf",
                    style: TextStyle(color: foregroundColor),
                  ),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(child: Divider(color: Colors.black)),
            SizedBox(child: Divider(color: Colors.black)),
            SizedBox(child: Divider(color: Colors.black)),
            SizedBox(child: Divider(color: Colors.black)),
            SizedBox(child: Divider(color: Colors.black)),
            SizedBox(child: Divider(color: Colors.black)),
            SizedBox(child: Divider(color: Colors.black)),
            Row(
              children: <Widget>[
                Text(
                  'location',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Expanded(
                  child: Text(
                    'locationText',
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.location_on,
                    color: foregroundColor,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
