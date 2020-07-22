import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/component/allHomeComponent/AvatarWidget.dart';
import 'package:mo8tarib/component/allHomeComponent/BottomNavBar.dart';
import 'package:mo8tarib/component/allHomeComponent/imageFlatWidget.dart';
import 'package:mo8tarib/global.dart';
import 'package:mo8tarib/localization.dart';
import 'package:mo8tarib/main.dart';
import 'package:mo8tarib/model/language.dart';
import 'package:mo8tarib/model/languageControler.dart';
import 'package:mo8tarib/model/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';


User currentUser;

class home extends StatefulWidget{
  //final User user;

  @override
  _homeState createState() =>_homeState();

  //home(this.user);

}

class _homeState extends State<home>{
  int whichAtive=1;

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

  List<String> image=["https://media.gettyimages.com/photos/hotel-room-in-the-new-hotel-complex-in-moscow-picture-id871617622?s=612x612",
    "https://q-cf.bstatic.com/images/hotel/max1024x768/222/222713113.jpg",
     "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQFHRtq_SQrHD4AepHJ79JGIa_rPg5uTj_wkw&usqp=CAU",
  "https://pix10.agoda.net/hotelImages/816/8162470/8162470_19062319400076757869.jpg?s=414x232&ar=16x9"];
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var localization = AppLocalizations.of(context);
    return Scaffold(
     backgroundColor:Colors.white70 ,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title:Image.asset("assets/images/logo.png",fit: BoxFit.cover,height: 70.0,),
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
      bottomNavigationBar: BottomNavBar(size: size),
      drawer:Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Container(
                color: color2,
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.spaceAround ,
                  children: [
                    AvatarWidget(
                      image:
                      NetworkImage('https://greendestinations.org/wp-content/uploads/2019/05/avatar-exemple.jpg')
                      //AssetImage('images/person.png')
                     // CachedNetworkImageProvider('https://greendestinations.org/wp-content/uploads/2019/05/avatar-exemple.jpg'),
                    ),
                    Text('Tata',style:TextStyle(color: color1,fontSize: 30))

  ]
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home

                  )
            )]
              ) ,)
          ],
        ),
      ) ,
    body: ListView.builder(
            padding: EdgeInsets.all(4),
            shrinkWrap: true,
          itemCount: 3,
            itemBuilder:(context,index)=> Padding(
              padding: EdgeInsets.all(5),
              child: AspectRatio(
              aspectRatio: 1.30,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:BorderRadius.circular(30)
                ),
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [AvatarWidget(
                              radius: 20,
                              image: NetworkImage('https://greendestinations.org/wp-content/uploads/2019/05/avatar-exemple.jpg')
                            //AssetImage('images/person.png')
                            // CachedNetworkImageProvider('https://greendestinations.org/wp-content/uploads/2019/05/avatar-exemple.jpg'),
                          ),
                            SizedBox(width: size.width*.03),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('firstName lastName',style:TextStyle(color: color1,fontSize:18)),
                                SizedBox(height: size.height*.007),
                                Text('Time',style:TextStyle(color: color1,fontSize:18)),
                              ], ),
                            Expanded(child: SizedBox()),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: (){},
                            )
                          ],
                        ),
                        Divider(color: color1,endIndent: size.width*.2,indent: size.width*.2,),
                        Text("اي كلام ع البوست "),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: ClampingScrollPhysics(),
                            itemCount: image.length,
                            itemBuilder:(context,index)=> imageFlatWidget(image:NetworkImage(image[index]) ,),
                          ),
                        )
                      ]
                  ),
                ),
              ),
          ),
            ),

          ),

        //SizedBox(height: (size.height)*0.01),



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

