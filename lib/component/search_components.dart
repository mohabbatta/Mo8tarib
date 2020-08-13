import 'package:flutter/material.dart';
class SearchRaisedButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String title;
  final Function function;
  const SearchRaisedButton(
      {Key key, this.color, this.textColor, this.title, this.function})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: color,
      elevation: 10,
      child: Text(
        title,
        style: TextStyle(fontFamily: 'VarelaRound', color: textColor),
      ),
      onPressed: function,
    );
  }
}
