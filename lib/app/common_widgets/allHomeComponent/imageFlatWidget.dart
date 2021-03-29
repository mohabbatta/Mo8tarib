import 'package:flutter/material.dart';
class ImageFlatWidget extends StatelessWidget {
  final ImageProvider image;
  ImageFlatWidget({this.image = const AssetImage('images/person.png')});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shape: BeveledRectangleBorder(),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 3, color: Colors.white),
          shape: BoxShape.rectangle,
        ),
        child: Image(
          image: image,
        ),
      ),
    );
  }
}
