import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/dashboard_layout.dart';
import 'package:mo8tarib/app/Screen/sign_in/add_inf.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/app/Screen/sign_in/sign_in_page.dart';
import 'package:mo8tarib/helper/shared_helper.dart';
import 'package:mo8tarib/services/auth.dart';
import 'package:mo8tarib/services/data_base.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print(SharedHelper.sharedPreferences.hashCode);

    final authBase = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder(
        stream: authBase.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            MyUser user = snapshot.data;
            if (user == null) {
              return SignInPage.create(context);
            }
            if (authBase.isNewUser!= null && authBase.isNewUser) {
              print(authBase.isNewUser);
              return AddINf.create(context, user);
            }
            print( authBase.isNewUser);
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
        });
  }
}
