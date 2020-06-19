import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/global.dart';
import 'package:mo8tarib/localization.dart';
import 'package:mo8tarib/main.dart';
import 'package:mo8tarib/model/language.dart';
import 'package:mo8tarib/model/languageControler.dart';
import 'package:mo8tarib/model/user.dart';

User currentUser;

class home extends StatefulWidget{
  //final User user;

  @override
  _homeState createState() =>_homeState();

  //home(this.user);

}

class _homeState extends State<home>{

 // post_bloc _bloc;

//  @override
//  void initState() {
//    super.initState();
////    _bloc=new post_bloc();
////    _bloc.fetchAllPosts();
//  //  print(widget.user.email);
//  }
//  @override
//  void dispose() {
//    // TODO: implement dispose
//    super.dispose();
//    //_bloc.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        height: size.height*0.09,
        color: color1,
        child: Row(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(
                  Icons.home,
                  color: color2,
                  size: size.height*.05,
                ),
//                Text('Home',style: TextStyle(color: color2,fontSize:size.height*.01 )),
              ],
            )
          ],
        ),
      ),
      drawer:Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(child:Image.network('https://conceptdraw.com/a1753c3/p1/preview/640/pict--athletic-guy-people---vector-stencils-library.png--diagram-flowchart-example.png')),
            )
          ],
        ),
      ) ,
//      body:StreamBuilder<List<post>>(
//           stream: _bloc.streampost,
//         builder: (context, allpost) {
//             if(allpost.hasData){
//             return Center(
//
//               child: Text(
//                   allpost.data[0].key
//               ),
//             );}else{
//               return Center(
//
//                   child: Text(
//                   'no data'
//               ),
//           );
//             }
//
//         }
//      )
    );

  }




  void _changeLanguage(language lang) async{
    languageControler controler = new languageControler();
    Locale _temp= await controler.SetLocale(lang.langCode);

    MyApp.setLocale(context, _temp);
    print(lang.name);
  }
}