import 'package:flutter/material.dart';
import 'package:mo8tarib/bloc/navigation_bloc.dart';
import 'package:mo8tarib/global.dart';

class HomeDas extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  const HomeDas({Key key, this.onMenuTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Colors.black.withOpacity(0.8),
      ),
//      child: IconButton(
//        icon: Icon(
//          Icons.menu,
//          size: 30,
//          color: foregroundColor,
//        ),
//        onPressed: onMenuTap,
//      ),
      child: Scaffold(
        appBar: AppBar(
          toolbarOpacity: 1,
          backgroundColor: backgroundColor2,
          centerTitle: true,
          title: Text(
            "Moغtrab",
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
        //TODO HOME Body
      ),
    );
  }
}
