import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/component/rounded_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:mo8tarib/global.dart';
import 'package:mo8tarib/localization.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double screenWidth, screenHeight;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    var localization = AppLocalizations.of(context);
    return Scaffold(
      //resizeToAvoidBottomPadding: true,
      // resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          Container(
            child: FlareActor(
              "images/login .flr",
              animation: "Flow",
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
//                Flexible(
//                  child: Container(
//                    height: 200,
//                    child: FlareActor(
//                      "images/map-marker.flr",
//                      //"images/login .flr",
//                      animation: "Search location",
//                    ),
//                  ),
//                ),
                    Text(
                      "Mo8trab",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 50, fontFamily: "Pacifico"),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FacebookButton(
                          onPressed: () {},
                        ),
                        TwitterButton(
                          onPressed: () {},
                        ),
                        InstagramButton(
                          onPressed: () {},
                        ),
                        GoogleButton(
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      decoration: KTextFieldDecoration.copyWith(
                        hintText: localization.translate("Enter your email."),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: KTextFieldDecoration.copyWith(
                          hintText:
                              localization.translate("Enter your password.")),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    new RoundButton(
                      colour: foregroundColor,
                      title: localization.translate("Log In"),
                    ),
//                GredientButton(
//                  onPressed: () {},
//                  splashColor: Colors.orange,
//                  colors: [
//                    Colors.red,
//                    Colors.orange,
//                  ],
//                  title: "Gredient Button",
//                ),

                    RawMaterialButton(
                      onPressed: () {
                        print("anythin");
                      },
                      //color: Colors.lightBlue,
                      child: Text(
                        localization.translate("Forgot password?"),
                        style: TextStyle(color: backgroundColor2),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          localization.translate("Don't have an account?"),
                          style: TextStyle(fontSize: 16),
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            print('mohaned');
                          },
                          child: Text(
                            localization.translate("Sign up"),
                            style:
                                TextStyle(fontSize: 18, color: foregroundColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
