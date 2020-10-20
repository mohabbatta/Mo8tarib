import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function socialFunction;
  const SocialIcon(
      {Key key, @required this.icon, this.color, this.socialFunction})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
          icon: FaIcon(
            icon,
            color: color,
            size: 50,
          ),
          onPressed: socialFunction),
    );
  }
}
