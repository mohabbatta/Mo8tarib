import 'package:flutter/material.dart';

import 'package:mo8tarib/localization.dart';
import 'package:mo8tarib/main.dart';


class home extends StatefulWidget{

  @override
  _homeState createState() =>_homeState();

}

class _homeState extends State<home>{

  var _swap =0;

  void _switchlang(){

    if(_swap==0){
      MyApp.setLocale(context, Locale('en', 'UK'));
      print("en");
    _swap=1;
    }
    else {
      MyApp.setLocale(context, Locale('ar', 'SA'));
      print("ar");
      _swap=0;
    }
  }
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.translate('nana')),
        //title: Text('tata'),
      ),
      body: Container(
        child: Center(
          child: FlatButton(
            child: Text(localization.translate('tata')),
            color: Theme.of(context).primaryColor,
            onPressed: _switchlang,

          ),

        ),

      ),
    );

  }


}