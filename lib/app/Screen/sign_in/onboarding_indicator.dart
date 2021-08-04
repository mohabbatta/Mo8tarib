import 'package:flutter/material.dart';
import 'package:mo8tarib/constants/color_constants.dart';

class Indicator extends StatelessWidget {
  final int positionIndex, currentIndex;
  const Indicator({this.currentIndex, this.positionIndex});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: 6,
      width: positionIndex == currentIndex ? 5 : 20,
      decoration: BoxDecoration(
          color: positionIndex == currentIndex
              ? ColorConstants.mainColor
              : Colors.black54,
          borderRadius: BorderRadius.all(Radius.circular(5))),
    );
  }
}
