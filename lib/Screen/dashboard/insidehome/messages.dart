import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  int height = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Column(
        children: <Widget>[
          RaisedButton(onPressed: () {
            setState(() {
              height = 20;
            });
          }),
          Text(height.toString())
        ],
      ),
    );
  }
}
