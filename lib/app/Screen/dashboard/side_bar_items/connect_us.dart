import 'package:flutter/material.dart';
import 'package:mo8tarib/app/bloc/navigation_bloc.dart';
import 'package:mo8tarib/global.dart';

class ConnectUs extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  const ConnectUs({Key key, this.onMenuTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "About us",
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
        decoration: BoxDecoration(
          //  borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
//        child: Center(
//          child: IconButton(
//            icon: Icon(
//              Icons.menu,
//              size: 30,
//              color: foregroundColor,
//            ),
//            onPressed: onMenuTap,
//          ),
//        ),
      ),
    );
  }
}
