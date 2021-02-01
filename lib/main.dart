import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mo8tarib/app/model/languageControler.dart';
import 'package:mo8tarib/landing_page.dart';
import 'package:mo8tarib/localization.dart';
import 'package:mo8tarib/services/auth.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

//
//class MyApp extends StatefulWidget {
//  static void setLocale(BuildContext context, Locale locale) {
//    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
//    state.setLocale(locale);
//  }
//
//  @override
//  _MyAppState createState() => _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> {
//  Locale _locale;
//
//  void setLocale(Locale locale) {
//    setState(() {
//      _locale = locale;
//    });
//  }
//
//  static Future<bool> getEmail() async {
//    SharedPreferences _shard = await SharedPreferences.getInstance();
//    String email = _shard.getString("email");
//    if (email == null) {
//      return false;
//    } else {
//      return true;
//    }
//  }
//
//  @override
//  void didChangeDependencies() {
//    languageControler controler = new languageControler();
//    controler.getLocale().then((locale) {
//      setState(() {
//        this._locale = locale;
//      });
//    });
//    super.didChangeDependencies();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    if (_locale == null) {
//      return Container(
//        child: Center(
//          child: CircularProgressIndicator(),
//        ),
//      );
//    } else {
//      return MaterialApp(
//        showSemanticsDebugger: false,
//        title: "Mo8tarib",
//        locale: _locale,
//        supportedLocales: [
//          Locale('fr'),
//          Locale('ar', 'SA'),
//          Locale('en', 'UK'),
//        ],
//        localizationsDelegates: [
//          AppLocalizations.delegate,
//          GlobalMaterialLocalizations.delegate,
//          GlobalWidgetsLocalizations.delegate,
//          GlobalCupertinoLocalizations.delegate,
//        ],
//        localeResolutionCallback: (locale, supportedLocales) {
//          // Check if the current device locale is supported
//          for (var supportedLocale in supportedLocales) {
//            if (supportedLocale.languageCode == locale.languageCode &&
//                supportedLocale.countryCode == locale.countryCode) {
//              return supportedLocale;
//            }
//          }
//          return supportedLocales.first;
//        },
//        debugShowCheckedModeBanner: false,
//        home: LandingPage(),
////        initialRoute: '/',
////        routes: {
////          '/': (context) => SignInPage(),
////          '/signup': (context) => SignUp2(),
////          '/home': (context) => DashBoardLayout(),
////          '/edituser': (context) => EditUser(),
////          '/postdetails': (context) => PostDetails(),
////          '/addinf': (context) => AddINf(),
////          '/forgetpassword': (context) => ForgetPassword(),
////          '/addproperty': (context) => MyProperty(),
////          '/searchmap': (context) => SearchMap(),
////          '/mapmarker': (context) => MapMarker(),
////          '/rent': (context) => Rent(),
////        },
//
//        //    home: EditUser(),
////        getEmail() == false? SignUp():home(new User('',0,{'fname':'tata','lname':'nana'},
////            'male','',[],'tt')),
//        //home: SignUp2()
////        routes: {
////          '/': (context) => Login(),
////          '/signup': (context) => SignUp2(),
////          '/home': (context) => DashBoardLayout(),
////        },
//      );
//    }
//  }
//}
///
class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print(snapshot.error.toString());
          return MaterialApp(home: Scaffold(body: Container(child: Center(child: Text('something error'),),)));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return  Provider<AuthBase>(
            create: (context) => Auth(),
            child: MaterialApp(
              title: 'Mo8trab',
              theme: ThemeData(primaryColor: Colors.indigo),
              home: LandingPage(),
            ),
          );

        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(child: Center(child: CircularProgressIndicator(),),);
      },
    );

  }
}
