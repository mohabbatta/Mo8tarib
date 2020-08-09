import 'package:flutter/material.dart';
import 'package:mo8tarib/Screen/add_inf.dart';
import 'package:mo8tarib/Screen/dashboard/dashboard_layout.dart';
import 'package:mo8tarib/Screen/dashboard/home1.dart';
import 'package:mo8tarib/Screen/forget_password.dart';
import 'package:mo8tarib/Screen/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mo8tarib/Screen/login.dart';
import 'package:mo8tarib/Screen/edit_user.dart';
import 'file:///C:/Users/Digital/AndroidStudioProjects/Mo8tarib/lib/Screen/post_details.dart';
import 'package:mo8tarib/localization.dart';
import 'package:mo8tarib/model/languageControler.dart';
import 'Screen/sign_up.dart';
import 'Screen/sign_up_2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screen/home.dart';
import 'Screen/sign_up.dart';
import 'model/user.dart';
import 'Screen/sign_up.dart';
import 'Screen/sign_up_2.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  static Future<bool> getEmail() async {
    SharedPreferences _shard = await SharedPreferences.getInstance();
    String email = _shard.getString("email");
    if (email == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void didChangeDependencies() {
    languageControler controler = new languageControler();
    controler.getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return MaterialApp(
        showSemanticsDebugger: false,
        title: "Mo8tarib",
        locale: _locale,
        supportedLocales: [
          Locale('fr'),
          Locale('ar', 'SA'),
          Locale('en', 'UK'),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        //home: SignUp2(),
        initialRoute: '/home',
        routes: {
          '/': (context) => Login(),
          '/signup': (context) => SignUp2(),
          '/home': (context) => DashBoardLayout(),
          '/edituser': (context) => EditUser(),
          '/postdetails': (context) => PostDetails(),
          '/addinf': (context) => AddINf(),
          '/forgetpassword': (context) => ForgetPassword(),
        },

        //    home: EditUser(),
//        getEmail() == false? SignUp():home(new User('',0,{'fname':'tata','lname':'nana'},
//            'male','',[],'tt')),
        //home: SignUp2()
//        routes: {
//          '/': (context) => Login(),
//          '/signup': (context) => SignUp2(),
//          '/home': (context) => DashBoardLayout(),
//        },
      );
    }
  }
}
