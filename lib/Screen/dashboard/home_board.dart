import 'package:flutter/material.dart';

class HomeBoard extends StatelessWidget {
  final bool isCollapsed;
  final double screenWidth, screenHeight;
  final Duration duration;
  final AnimationController controller;
  final Animation<double> scaleAnimation;
  final Function onMenuTap;
  final Widget child;

  const HomeBoard(
      {Key key,
      this.isCollapsed,
      this.screenWidth,
      this.screenHeight,
      this.duration,
      this.controller,
      this.scaleAnimation,
      this.onMenuTap,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.5 * screenWidth,
      right: isCollapsed ? 0 : -0.4 * screenWidth,
      duration: duration,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Material(
          animationDuration: duration,
          //borderRadius: BorderRadius.all(Radius.circular(20)),
          elevation: 4,
          child: child,
        ),
      ),
    );
  }
}
