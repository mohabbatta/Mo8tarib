import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mo8tarib/app/Screen/on_boarding/started_page.dart';
import 'package:mo8tarib/helper/shared_helper.dart';
import 'package:mo8tarib/landing_page.dart';
import 'package:mo8tarib/helper/localization.dart';
import 'package:mo8tarib/services/app_language.dart';
import 'package:mo8tarib/services/auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHelper.init();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(
    appLanguage: appLanguage,
  ));
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final AppLanguage appLanguage;

  MyApp({this.appLanguage});
  @override
  Widget build(BuildContext context) {
    var onBoarding = SharedHelper.getBool(key: SharedAPi.onBoarding);
    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => appLanguage,
      child: Consumer<AppLanguage>(
        builder: (context, model, child) {
          print(model.appLocal);
          return MaterialApp(
            locale: model.appLocal,
            supportedLocales: [
              Locale('en', 'US'),
              Locale('ar', ''),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            title: 'Mo8trab',
            theme: ThemeData(
              primaryColor: Colors.white,
              scaffoldBackgroundColor: Colors.white
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,

              //backgroundColor: Colors.black12
              // bottomAppBarColor: Colors.black12
            ),
            home: FutureBuilder(
              // Initialize FlutterFire:
              future: _initialization,
              builder: (context, snapshot) {
                // Check for errors
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Scaffold(
                      body: Container(
                    child: Center(
                      child: Text('something error'),
                    ),
                  ));
                }

                // Once complete, show your application
                if (snapshot.connectionState == ConnectionState.done) {
                  print("onBoarding $onBoarding");
                  if(onBoarding == null || !onBoarding){
                   return StartedPage();
                  }else{
                    return Provider<AuthBase>(
                      create: (context) => Auth(),
                      child: LandingPage(),
                    );

                  }
                }

                // Otherwise, show something whilst waiting for initialization to complete
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

//////////