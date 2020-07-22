import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mo8tarib/component/rounded_button.dart';
import 'package:mo8tarib/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global.dart';
import 'package:mo8tarib/localization.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _firestore =Firestore.instance;
final _auth =FirebaseAuth.instance;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool showSpinner =false;

  TextEditingController _fnameController;
  TextEditingController _lnameController;
  TextEditingController _emailController;
  TextEditingController _passController;

  @override
  void initState() {
    super.initState();
  _emailController=new TextEditingController();
  _fnameController=new TextEditingController();
  _lnameController=new TextEditingController();
  _passController=new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    var localization = AppLocalizations.of(context);
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: SingleChildScrollView(
              child:
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
           children: <Widget>[
              IconButton(
              icon: Icon(Icons.arrow_back),
              alignment: Alignment.topLeft,
              iconSize: 30,
              onPressed: () {},
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                localization.translate("Sign_up"),
                style: TextStyle(
                    fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton.icon(
                    color: Color(0xff0B83ED),
                    onPressed: () {},
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                    ),
                    icon: FaIcon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Face Book',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton.icon(
                    color: Color(0xff1DA1F2),
                    onPressed: () {},
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                    ),
                    icon: FaIcon(
                      FontAwesomeIcons.twitter,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Twitter',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            TextField(
              controller: _fnameController,
              textAlign: TextAlign.left,
              decoration: KTextFieldDecoration.copyWith(
                  hintText: localization.translate("First_Name")),
            ),
          TextField(
            textAlign: TextAlign.left,
            decoration: KTextFieldDecoration.copyWith(
                hintText: localization.translate("First Name")),
          ),
          SizedBox(
            height: 24.0,
          ),
          TextField(
            textAlign: TextAlign.left,
            decoration: KTextFieldDecoration.copyWith(
                hintText: localization.translate("Last Name")),
          ),
          SizedBox(
            height: 24.0,
          ),
          TextField(
            textAlign: TextAlign.left,
            decoration: KTextFieldDecoration.copyWith(
                hintText: localization.translate("Email")),
          ),
          SizedBox(
            height: 24.0,
          ),
          TextField(
            textAlign: TextAlign.left,
            decoration: KTextFieldDecoration.copyWith(
                hintText: localization.translate("Password")),
          ),
          SizedBox(
            height: 24.0,
          ),
          new RoundedButton(
            title: localization.translate("Sign_up"),
            colour: Colors.lightBlueAccent,
            onPressed: null,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              localization.translate(
                  "By_Signing_Up_You_Agreed_with_our_terms_of_Services_and_privacy_polices"),
              style: TextStyle(),
              textAlign: TextAlign.center,

            ),),
            TextField(
              controller: _lnameController,
              textAlign: TextAlign.left,
              decoration: KTextFieldDecoration.copyWith(
                  hintText: localization.translate("Last_Name")),
            ),
            SizedBox(
              height: 24.0,
            ),
            TextField(
              controller: _emailController,
              textAlign: TextAlign.left,
              decoration: KTextFieldDecoration.copyWith(
                  hintText: localization.translate("Email")),
            ),
            SizedBox(
              height: 24.0,
            ),
            TextField(
              controller: _passController,
              obscureText: true,
              textAlign: TextAlign.left,
              decoration: KTextFieldDecoration.copyWith(
                  hintText: localization.translate("Password")),
            ),
            SizedBox(
              height: 24.0,
            ),
            new RoundedButton(
              title: localization.translate("Sign_up"),
              colour: Colors.lightBlueAccent,
              onPressed: () async {
                print("انا دخلت اهو");
                setState(() {
                  showSpinner=true;
                });
                try{
                  print("اول التراي اهو");
                  final newUser=await _auth.createUserWithEmailAndPassword
                    (email: _emailController.text, password: _passController.text);
                  SharedPreferences _shard=await SharedPreferences.getInstance();

                  await _shard.setString("email",_emailController.text);
                  await _shard.setString("pass",_passController.text);

                  print("عدبت الاوث اهو");
                  if(newUser!=null){
                    _firestore.collection('user').add({
                      'address':{},
                      'age':0,
                      'email':_emailController.text,
                      'fname':_fnameController.text
                    });
                    print("الحمدلله الداتا اتحفظت كمان اهو");
//                            Navigator.push(context,
//                                MaterialPageRoute(builder: (context)=>home(
//                                    new User('',0,{'fname':_fnameController.text,'lname':_fnameController.text},
//                                        'male',_passController.text,[],_emailController.text )
//                                )));
                  }
                  setState(() {
                    showSpinner=false;
                  });
                }catch(e){print(e);}



              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                localization.translate(
                    "By_Signing_Up_You_Agreed_with_our_terms_of_Services_and_privacy_polices"),
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text( localization.translate("Already_Have_Account?"),
                  textAlign: TextAlign.center,
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    localization.translate("Log_In"),
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            ],
          ),
            ),
          ),
        ),
      ),
    );
  }
}
