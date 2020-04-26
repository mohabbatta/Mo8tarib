import 'package:flutter/material.dart';
import 'package:mo8tarib/Screen/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mo8tarib/localization.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  static void setLocale (BuildContext context ,Locale locale){
  _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
  state.setLocale(locale);
  }
   @override
    _MyAppState createState() =>_MyAppState();
}

class _MyAppState extends State<MyApp>{
  Locale _locale=Locale('ar', 'SA');

  void setLocale (Locale locale){

    setState(() {
      _locale=locale;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp (

      title: "Mo8tarib",
      locale: _locale,
      supportedLocales: [
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
      home: home(),
    );
  }

}

