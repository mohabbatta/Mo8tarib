import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/app/common_widgets/rounded_button.dart';
import 'package:mo8tarib/global.dart';
import 'package:mo8tarib/localization.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  double screenWidth, screenHeight;
  bool showSpinner = false;
  String email;
  TextEditingController emailController;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void submit() {
    setState(() {
      showSpinner = true;
    });
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> _showMyDialog(String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reset password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
                Text(emailController.text),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'ok',
                style: TextStyle(color: foregroundColor),
              ),
              onPressed: () {
                if (text == 'please enter Email') {
                  Navigator.of(context).pop();
                } else {
                  Navigator.pushNamed(context, '/');
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    emailController = TextEditingController(text: email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: foregroundColor,
        child: Stack(
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Reset password",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 25, fontFamily: "VareaRound"),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: emailController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        decoration: KTextFieldDecoration.copyWith(
                          hintText: localization.translate("Enter your email."),
                        ),
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Builder(
                        builder: (context) {
                          return RoundButton(
                              colour: foregroundColor,
                              title: localization.translate("Reset Password"),
                              onPressed: () {
                                //  submit();
                                if (emailController.text != null) {
                                  resetPassword(emailController.text);
                                  _showMyDialog('please check Email send to');
                                  print("send email");
                                } else {
                                  _showMyDialog('please enter Email');
                                }
                              });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
