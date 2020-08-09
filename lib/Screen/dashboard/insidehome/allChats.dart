import 'package:flutter/material.dart';
import 'package:mo8tarib/model/user.dart';

import 'messages.dart';

class AllChats extends StatefulWidget {
  @override
  _AllChatsState createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Container(
        width: 200,
        height: 200,
        child: Center(
          child: RawMaterialButton(
                  onPressed: () {
                    print('mohaned');
                    Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>Messages(
                        new User('',0,{'fname':"",'lname':""},
                                        'male','',[],''),
                       new User('',0,{'fname':"",'lname':""},
                                        'male','',[],'')
                    )
                    ));
                  },
                  child: Text(
                   'tata',
                    style:
                        TextStyle(fontSize: 18, color: Colors.lightBlueAccent),
                  ),
                ),
        )
      ),
    );
  }

}