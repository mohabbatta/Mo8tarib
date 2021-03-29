import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/settings/choose_language.dart';
import 'package:mo8tarib/app/bloc/navigation_bloc.dart';
import 'package:mo8tarib/constants/global.dart';

class SettingPage extends StatefulWidget with NavigationStates{
  final Function onMenuTap;

   SettingPage({Key key, this.onMenuTap}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // PersistentBottomSheetController _controller;
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  //
  // void _createBottomSheet() {
  //   _controller =  _scaffoldKey.currentState.showBottomSheet((context) {
  //     var index = 1;
  //     var appLanguage = Provider.of<AppLanguage>(context);
  //     return Container(
  //       height: 350.0,
  //       color: Color(0xFF737373),
  //       child: Container(
  //           decoration: new BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: new BorderRadius.only(
  //                   topLeft: const Radius.circular(20.0),
  //                   topRight: const Radius.circular(20.0))),
  //           child: Column(
  //             children: [
  //               GestureDetector(
  //                 onTap: () {
  //                   index = 0;
  //                   appLanguage.changeLanguage(Locale("en"));
  //                   setState(() {
  //                      appLanguage.changeLanguage(Locale("en"));
  //                   });
  //                 },
  //                 child: Container(
  //                   height: 90,
  //                   decoration: BoxDecoration(
  //                     color: appLanguage.appLocal.languageCode == "en"
  //                         ? foregroundColor
  //                         : Colors.white,
  //                     border: Border(
  //                       bottom: BorderSide(width: 2.0, color: Colors.black12),
  //                     ),
  //                   ),
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Image.asset(
  //                               "images/english.png",
  //                               height: 70,
  //                               width: 70,
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.symmetric(horizontal: 12),
  //                               child: Text("English"),
  //                             ),
  //                           ],
  //                         ),
  //                         appLanguage.appLocal.languageCode == "en"
  //                             ? Icon(Icons.check)
  //                             : SizedBox(),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   index = 1;
  //                   appLanguage.changeLanguage(Locale("ar"));
  //                   setState(() {
  //                     // appLanguage.changeLanguage(Locale("ar"));
  //                   });
  //                 },
  //                 child: Container(
  //                   height: 90,
  //                   decoration: BoxDecoration(
  //                     color: appLanguage.appLocal.languageCode == "ar"
  //                         ? foregroundColor
  //                         : Colors.white,
  //                     border: Border(
  //                       bottom: BorderSide(width: 2.0, color: Colors.black12),
  //                     ),
  //                   ),
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Image.asset(
  //                               "images/egypt.png",
  //                               height: 70,
  //                               width: 70,
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.symmetric(horizontal: 12),
  //                               child: Text("عربي"),
  //                             ),
  //                           ],
  //                         ),
  //                         appLanguage.appLocal.languageCode == "ar"
  //                             ? Icon(Icons.check)
  //                             : SizedBox(),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               )
  //             ],
  //           )),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Setting",
          style: TextStyle(
            color: foregroundColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            size: 30,
            color: foregroundColor,
          ),
          onPressed: widget.onMenuTap,
        ),
      ),
      body: Container(
        child:  Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChooseLanguage()),
              );       },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Choose Language",style: TextStyle(fontSize: 22),),
                Text("Arabic",style: TextStyle(fontSize: 22),),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
