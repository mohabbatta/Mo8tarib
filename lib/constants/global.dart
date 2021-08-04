import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mo8tarib/constants/color_constants.dart';

const kGreyLabelTextStyle = TextStyle(
  color: Colors.grey,
  fontFamily: 'STC',
);
const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: ColorConstants.primaryColor, width: 2.0),
  ),
);

const kUsernameTextStyle = TextStyle(
  fontFamily: 'STC',
  color: Colors.white,
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

const kSendButtonTextStyle = TextStyle(
  color: ColorConstants.primaryColor,
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
    borderSide: BorderSide(color: ColorConstants.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: ColorConstants.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
