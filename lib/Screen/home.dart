import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/global.dart';
import 'package:mo8tarib/localization.dart';
import 'package:mo8tarib/main.dart';
import 'package:mo8tarib/model/language.dart';
import 'package:mo8tarib/model/languageControler.dart';
import 'package:shared_preferences/shared_preferences.dart';


class home extends StatefulWidget{

  @override
  _homeState createState() =>_homeState();

}

class _homeState extends State<home>{

 void _changeLanguage(language lang) async{
  languageControler controler = new languageControler();
  Locale _temp= await controler.SetLocale(lang.langCode);

 MyApp.setLocale(context, _temp);
    print(lang.name);
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title:Center(
          child :Text(localization.translate('nana'),
            style: TextStyle(color: color2),
          ),
        ),
        backgroundColor: color1,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: DropdownButton(
              onChanged: (language lang){
                _changeLanguage(lang);
              },
                underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: color2,
              ),
              items:language.languageList()
               .map<DropdownMenuItem<language>>((lang)=>DropdownMenuItem(
                value: lang,
                child: Container(
                  color: color2,
                  child: Row(
                    children: <Widget>[
                      Text(lang.flage,style: TextStyle(color: color2),),
                      Text(lang.name,style: TextStyle(color: color1)),
                    ],
                  ),
                ),
              )).toList()
              ),

            ),

        ],
      ),


      bottomNavigationBar: new BottomNavigationBar(items:[
        new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text("home")
    ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.track_changes),
            title: new Text("change"),
        ),
      ],
      backgroundColor: color1,
      fixedColor: color2,
      unselectedItemColor: color2,),
    );

  }


}