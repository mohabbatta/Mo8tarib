import 'package:flutter/material.dart';
import 'package:mo8tarib/bloc/navigation_bloc.dart';
import 'package:mo8tarib/global.dart';

class Flat extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  const Flat({Key key, this.onMenuTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.deepOrange,
      ),
      child: Center(
        child: IconButton(
          icon: Icon(
            Icons.menu,
            size: 30,
            color: foregroundColor,
          ),
          onPressed: onMenuTap,
        ),
      ),
    );
  }
}
