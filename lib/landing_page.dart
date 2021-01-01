import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/dashboard_layout.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/app/Screen/sign_in/sign_in_page.dart';
import 'package:mo8tarib/services/auth.dart';
import 'package:mo8tarib/services/data_base.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBase = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder(
        stream: authBase.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.hasData) {
              User user = snapshot.data;
              if (user == null) {
                return SignInPage.create(context);
              }
              return Provider<Database>(
                  create: (_) => FireStoreDatabase(uid: user.uid),
                  child: DashBoardLayout(
                    uid: user.uid,
                  ));
            } else {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          } else {
            return SignInPage.create(context);
          }
        });
  }
}
