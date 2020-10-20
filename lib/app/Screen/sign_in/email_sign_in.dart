import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/sign_in/email_sign_in_page.dart';

class EmailSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Time Tracker'),
//        elevation: 2.0,
//      ),
      // backgroundColor: Colors.grey[200],
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
            child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Card(
                    child: EmailSignInPage.create(context),
                    color: Colors.white.withOpacity(1),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
