import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

Widget onBoardingScreen({
  String imageName,
  GifController controller,
  String mainText,
  BuildContext context
}) {
  return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GifImage(
            controller: controller,
            image: AssetImage(imageName),
            width: MediaQuery.of(context).size.width * 0.7,
            // color: Colors.teal,
          ),
          Text(
            mainText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
            ),
          ),
        ],
      ));
}
