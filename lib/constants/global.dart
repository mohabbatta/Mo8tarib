import 'dart:ui';
import 'package:flutter/material.dart';

const color1 = const Color(0xff000000);
const color2 = const Color(0xffffa41b);

const Color backgroundColor1 = Color(0xf000000);
const Color backgroundColor2 = Color(0xff141418);
const Color foregroundColor = Color(0xffFFA41B);
const kAskScreenPrimary = Color(0xff3F51B5);
const kGreyLabelTextStyle = TextStyle(
  color: Colors.grey,
  fontFamily: 'STC',
);
const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: color2, width: 2.0),
  ),
);

const kUsernameTextStyle = TextStyle(
  fontFamily: 'STC',
  color: Colors.white,
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

const kSendButtonTextStyle = TextStyle(
  color: color2,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const KTextFieldDecoration = InputDecoration(
  hintText: 'Enter your value.',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: backgroundColor2, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: backgroundColor2, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
