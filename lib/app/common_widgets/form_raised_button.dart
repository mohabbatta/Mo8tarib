import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/app/common_widgets/custom_raised_button.dart';
import 'package:mo8tarib/constants/global.dart';

class FormRaisedButton extends CustomRaisedButton {
  FormRaisedButton({
    @required String text,
    @required VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          height: 44.0,
          color: foregroundColor,
          onPressed: onPressed,
        );
}
