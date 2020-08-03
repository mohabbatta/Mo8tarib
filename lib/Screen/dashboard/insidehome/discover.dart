import 'package:flutter/material.dart';
import 'package:mo8tarib/bloc/navigation_bottom.dart';

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  int height = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Container(
        width: 200,
        height: 200,
        child: Slider(
            value: height.toDouble(),
            min: 0,
            max: 220,
            onChanged: (double newValue) {
              setState(() {
                height = newValue.round();
              });
            }),
      ),
    );
  }
}
