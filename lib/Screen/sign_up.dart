import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mo8tarib/component/rounded_button.dart';
import '../global.dart';
import 'package:mo8tarib/localization.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  alignment: Alignment.topLeft,
                  iconSize: 30,
                  onPressed: () {},
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    localization.translate("Sign up"),
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton.icon(
                        color: Color(0xff0B83ED),
                        onPressed: () {},
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                        ),
                        icon: FaIcon(
                          FontAwesomeIcons.facebookF,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Face Book',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      RaisedButton.icon(
                        color: Color(0xff1DA1F2),
                        onPressed: () {},
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                        ),
                        icon: FaIcon(
                          FontAwesomeIcons.twitter,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Twitter',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
                  textAlign: TextAlign.left,
                  decoration: KTextFieldDecoration.copyWith(
                      hintText: localization.translate("First Name")),
                ),
                SizedBox(
                  height: 24.0,
                ),
                TextField(
                  textAlign: TextAlign.left,
                  decoration: KTextFieldDecoration.copyWith(
                      hintText: localization.translate("Last Name")),
                ),
                SizedBox(
                  height: 24.0,
                ),
                TextField(
                  textAlign: TextAlign.left,
                  decoration: KTextFieldDecoration.copyWith(
                      hintText: localization.translate("Email")),
                ),
                SizedBox(
                  height: 24.0,
                ),
                TextField(
                  textAlign: TextAlign.left,
                  decoration: KTextFieldDecoration.copyWith(
                      hintText: localization.translate("Password")),
                ),
                SizedBox(
                  height: 24.0,
                ),
                new RoundedButton(
                  title: localization.translate("Sign up"),
                  colour: Colors.lightBlueAccent,
                  onPressed: null,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    localization.translate(
                        "By Signing Up You Agreed with our terms of Services and privacy polices"),
                    style: TextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      localization.translate("Already Have Account?"),
                      textAlign: TextAlign.center,
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Text(
                        localization.translate("Log In"),
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
