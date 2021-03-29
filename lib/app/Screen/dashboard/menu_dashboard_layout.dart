import 'package:flutter/material.dart';
import 'package:mo8tarib/services/app_language.dart';
import 'package:provider/provider.dart';

class MenuDashBoardLayout extends StatelessWidget {
  final bool isCollapsed;
  final double screenWidth, screenHeight;
  final Duration duration;
  final AnimationController controller;
  final Animation<double> scaleAnimation;
  final Function onMenuTap;
  final Widget child;

  const MenuDashBoardLayout({
    Key key,
    this.isCollapsed,
    this.screenWidth,
    this.screenHeight,
    this.duration,
    this.controller,
    this.scaleAnimation,
    this.onMenuTap,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);

    return Container(
      child:appLanguage.appLocal.languageCode == "en" ? AnimatedPositioned(
        top: 0,
        bottom: 0,
        left: isCollapsed ? 0 : 0.5 * screenWidth,
        right: isCollapsed ? 0 : -0.4 * screenWidth,
        duration: duration,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Material(
            animationDuration: duration,
            elevation: 4,
            child: child,
          ),
        ),
      ):AnimatedPositioned(
        top: 0,
        bottom: 0,
        right: isCollapsed ? 0 : 0.5 * screenWidth,
        left: isCollapsed ? 0 : -0.4 * screenWidth,
        duration: duration,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Material(
            animationDuration: duration,
            elevation: 4,
            child: child,
          ),
        ),
      )
    );
  }
}
