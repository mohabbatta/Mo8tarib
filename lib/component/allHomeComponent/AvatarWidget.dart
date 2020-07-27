import 'package:flutter/material.dart';
class AvatarWidget extends StatelessWidget {
  final double radius;
  final ImageProvider image;


  AvatarWidget({this.radius=40, this.image = const AssetImage('images/person.png')});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shape: CircleBorder(),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 3, color: Colors.white),
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: radius,
          backgroundImage: image,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}