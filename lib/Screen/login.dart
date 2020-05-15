import 'package:flutter/material.dart';
import 'package:mo8tarib/component/rounded_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:mo8tarib/global.dart';
import 'package:mo8tarib/localization.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
    var localization = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Container(
                height: 200,
                child: FlareActor(
                  "images/map-marker.flr",
                  animation: "Search location",
                ),
              ),
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              decoration: KTextFieldDecoration.copyWith(
                  hintText: localization.translate("Enter your email.")),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: KTextFieldDecoration.copyWith(
                  hintText: localization.translate("Enter your password.")),
            ),
            SizedBox(
              height: 24.0,
            ),
            new RoundedButton(
              colour: Colors.lightBlueAccent,
              title: localization.translate("Log In"),
            ),
            RawMaterialButton(
              onPressed: () {
                print("anythin");
              },
              //color: Colors.lightBlue,
              child: Text(
                localization.translate("Forgot password?"),
                style: TextStyle(color: Colors.lightBlue),
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
                        TextStyle(fontSize: 18, color: Colors.lightBlueAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
