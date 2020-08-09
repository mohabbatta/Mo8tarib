import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mo8tarib/model/user.dart';

import '../../../global.dart';

final _firestore =Firestore.instance;
FirebaseUser loggedInUser;

class Messages extends StatefulWidget {

  User curr;
  User receiver;


  Messages(this.curr, this.receiver);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

  final massageTextContrller= TextEditingController();
  String massageText;
  final _auth =FirebaseAuth.instance;
  User rece,current;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    rece=widget.receiver;
    current=widget.curr;
  }
  void getCurrentUser()async{
    try{
      final user=await _auth.currentUser();
      if(user != null){
        loggedInUser=user;
        print(loggedInUser.email);
      }}catch(e){print(e);}

  }

  void getMassagesStream() async{
    await for (var snapshot in _firestore.collection('massages').snapshots()){
      for(var massage in snapshot.documents){

        print(massage.data);
      }}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MassagesStream(rece,current),

            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: massageTextContrller,
                        onChanged: (value) {
                          massageText=value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        DateTime _currentTime=new DateTime.now();
                        massageTextContrller.clear();
                        _firestore.collection('massages')
                        .add({
                         'text':massageText,
                         'sender':loggedInUser.email,
                         'time':_currentTime,
                         'user receiver':'0TIsUhY1r66ipNK5Xwif',
                          'user sender':'1PzYDowdcBrefvuQtPTG'

                        });
//                      setState(() {
//
//                      });
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
int i;
class MassagesStream extends StatelessWidget {
  User rece,curr;


  MassagesStream(this.rece, this.curr);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('massages')
           .where("user receiver",whereIn:["0TIsUhY1r66ipNK5Xwif","1PzYDowdcBrefvuQtPTG"])
         // .where("user sender",isEqualTo: "0TIsUhY1r66ipNK5Xwif")
          .where("user sender", isEqualTo:"1PzYDowdcBrefvuQtPTG")
          .snapshots(),
      builder: (context,snapshot){

        if(!snapshot.hasData){

          print('no data');
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
              
            ),
          );
        }
        final massages =snapshot.data.documents.reversed;
        List<MassageBubble> massageWidgets=[];
        i=  massages.toList().length;
        int x=0;
        for(var massage in massages){
          print("iiiiiiiiiiiii$i");
          print('tata1');
         // final Map massageText=massage.data['text$x'];
        //  final massageSender=massage.data['sender'];
         // final currentUser=loggedInUser.email;
          final massageWidget =MassageBubble
            (
            text: massage.data['text'],
            sender: massage.data['sender'],
          //  isMe: currentUser==massageSender,
                );
          massageWidgets.add(massageWidget);
       x++; }
        return Expanded(
          child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
              children: massageWidgets
          ),
        );

      },
    );
  }
}

class MassageBubble extends StatelessWidget{

  MassageBubble({this.text,this.sender,this.isMe=false});

  final String text;
  final String sender;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    print('tata');
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: <Widget>[
          Text(sender,
            style: TextStyle(
                fontSize: 12.0,
                color: Colors.black45
            ),),
          Material(
            borderRadius:isMe? BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)
            ):
            BorderRadius.only(
                topRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)
            ),
            elevation: 5.0,
            color: isMe?Colors.lightBlueAccent:Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              child: Text(text ,
                style: TextStyle(
                    color:isMe?Colors.white :Colors.lightBlueAccent,
                    fontSize: 15.0),),
            ),
          ),
        ],
      ),
    );
  }

}
