import 'package:flutter/material.dart';
import 'package:mo8tarib/bloc/navigation_bloc.dart';

import '../../global.dart';

class Profile extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  const Profile({Key key, this.onMenuTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.redAccent,
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
