import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mo8tarib/Screen/dashboard/dashboard_layout.dart';
import 'package:mo8tarib/component/rounded_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:mo8tarib/component/social_icon.dart';
import 'package:mo8tarib/global.dart';
import 'package:mo8tarib/localization.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUp2 extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<SignUp2> {
  double screenWidth, screenHeight;

  final _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  GoogleSignIn _googleSignIn = new GoogleSignIn();

  // FacebookLogin fbLogin = new FacebookLogin();
//
  void _signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logInWithReadPermissions(['email']);
    //FacebookAccessToken facebookAccessToken = result.accessToken;

    final AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: result.accessToken.token,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        print('Successfully signed in with Facebook. ' + user.email);
        Navigator.pushNamed(context, '/home');
      } else {
        print('Failed to sign in with Facebook. ');
      }
    });
  }

  Future<void> handleSignIn() async {
    print("start");
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    print("google done");

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));

    _user = result.user;

    print(_user.displayName);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DashBoardLayout()));
  }

//  final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//  Future<FirebaseUser> _handleSignIn() async {
//    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//      accessToken: googleAuth.accessToken,
//      idToken: googleAuth.idToken,
//    );
//    final FirebaseUser user =
//        (await _auth.signInWithCredential(credential)) as FirebaseUser;
//    print("signed in " + user.displayName);
//    return user;
//  }

//  Future<FirebaseUser> _handleSignIn() async {
//    print("start handel google sign");
//    // hold the instance of the authenticated user
//    FirebaseUser user;
//    // flag to check whether we're signed in already
//    bool isSignedIn = await _googleSignIn.isSignedIn();
//    if (isSignedIn) {
//      // if so, return the current user
//      print("user signed ");
//      user = await _auth.currentUser();
//    } else {
//      print("new user");
//      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//      final GoogleSignInAuthentication googleAuth =
//          await googleUser.authentication;
//      // get the credentials to (access / id token)
//      // to sign in via Firebase Authentication
//      final AuthCredential credential = GoogleAuthProvider.getCredential(
//          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
//      user = (await _auth.signInWithCredential(credential)).user;
//    }
//
//    print("return user");
//    return user;
//  }
//
//  void onGoogleSignIn() async {
//    print("start google sign in");
//    FirebaseUser user = await _handleSignIn();
//    print("back with user");
//    print(user.email);
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => DashBoardLayout()));
//    if (user != null) {
//      print(user.displayName);
//      Navigator.pushNamed(context, '/home');
//    }
//  }

//  final facebookLogin = FacebookLogin();
//
//  Future<FirebaseUser> _signIn(BuildContext context) async {
//    Scaffold.of(context).showSnackBar(new SnackBar(
//      content: new Text('Sign in button clicked'),
//    ));
//
//    final result = await facebookLogin.logInWithReadPermissions(['email']);
////
////    FirebaseUser user =
////        await _auth.(accessToken: result.accessToken.token);
////    //Token: ${accessToken.token}
////
////    Navigator.push(
////      context,
////      new MaterialPageRoute(
////        builder: (context) => DashBoardLayout(),
////      ),
////    );
////
////    return user;
////    switch (result.status) {
////      case FacebookLoginStatus.loggedIn:
////        FirebaseUser user =
////            await _auth.sign
////        break;
////      case FacebookLoginStatus.cancelledByUser:
////        _showCancelledMessage();
////        break;
////      case FacebookLoginStatus.error:
////        _showErrorOnUI(result.errorMessage);
////        break;
////    }
//  }

  @override
  Widget build(BuildContext context) {
    String email;
    String password;

    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    var localization = AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: FlareActor(
              "images/login .flr",
              animation: "Flow",
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Mo8trab",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 50, fontFamily: "Pacifico"),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 25, fontFamily: "VareaRound"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocialIcon(
                            icon: FontAwesomeIcons.facebook,
                            color: Colors.indigo,
                            socialFunction: _signInWithFacebook
//                                () async {
//                              final facebookLogin = FacebookLogin();
//                              final result = await facebookLogin
//                                  .logInWithReadPermissions(['email']);
//
//                              switch (result.status) {
//                                case FacebookLoginStatus.loggedIn:
//                                  Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (context) =>
//                                              DashBoardLayout()));
//                                  break;
//                                case FacebookLoginStatus.cancelledByUser:
//                                  print("cancelledbyuser");
//                                  break;
//                                case FacebookLoginStatus.error:
//                                  print("error");
//                                  break;
//                              }
//                            }

                            //
                            //_signInWithFacebook
//                                () {
//                              fbLogin.logInWithReadPermissions(
//                                  ['email', 'public_profile']).then((result) {
//                                switch (result.status) {
//                                  case FacebookLoginStatus.loggedIn:
//                                    FirebaseAuth.instance.
//                                        .signInWithFacebook(
//                                            accessToken:
//                                                result.accessToken.token)
//                                        .then((signedInUser) {
//                                      print(
//                                          'Signed in as ${signedInUser.displayName}');
//                                      Navigator.of(context)
//                                          .pushReplacementNamed('/homepage');
//                                    }).catchError((e) {
//                                      print(e);
//                                    });
//                                    break;
//                                  case FacebookLoginStatus.cancelledByUser:
//                                    print('Cancelled by you');
//                                    break;
//                                  case FacebookLoginStatus.error:
//                                    print('Error');
//                                    break;
//                                }
//                              }).catchError((e) {
//                                print(e);
//                              });
//                            },
                            ),
                        SocialIcon(
                            icon: FontAwesomeIcons.googlePlus,
                            color: Colors.red,
                            socialFunction: handleSignIn
                            //() {}
                            //  onGoogleSignIn
                            ),
                        SocialIcon(
                            icon: FontAwesomeIcons.twitter,
                            color: Colors.blueAccent,
                            socialFunction: () {})
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      decoration: KTextFieldDecoration.copyWith(
                          hintText:
                              localization.translate("Enter your email.")),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: KTextFieldDecoration.copyWith(
                          hintText:
                              localization.translate("Enter your password.")),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    new RoundButton(
                      colour: foregroundColor,
                      title: localization.translate("Sign up"),
                      onPressed:
//                            () {
//                          print(email);
//                          print(password);
//                        }
                          () async {
                        try {
                          print(email);
                          print(password);
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            Navigator.pushNamed(context, '/home');
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          localization.translate("Already Have Account?"),
                          style: TextStyle(fontSize: 16),
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            localization.translate("Log In"),
                            style:
                                TextStyle(fontSize: 18, color: foregroundColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
