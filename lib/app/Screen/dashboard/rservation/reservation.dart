import 'package:flutter/material.dart';
import 'package:mo8tarib/app/bloc/navigation_bloc.dart';
import 'package:mo8tarib/constants/global.dart';

class Reservation extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  const Reservation({Key key, this.onMenuTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "reservation",
          style: TextStyle(
            color: foregroundColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            size: 30,
            color: foregroundColor,
          ),
          onPressed: onMenuTap,
        ),
      ),
      body: Container(
      ),
    );
  }
}
