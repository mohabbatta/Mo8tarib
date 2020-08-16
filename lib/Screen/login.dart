import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mo8tarib/Screen/dashboard/dashboard_layout.dart';
import 'package:mo8tarib/component/rounded_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:mo8tarib/component/social_icon.dart';
import 'package:mo8tarib/global.dart';
import 'package:mo8tarib/localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double screenWidth, screenHeight;
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  FirebaseUser _user;

  String email;
  String password;

  void submit() {
    setState(() {
      showSpinner = true;
    });
  }

  login(BuildContext context) async {
    try {
      final _user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("check user");
      if (_user != null) {
        print("loggin");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashBoardLayout(),
            ));
        setState(() {
          showSpinner = false;
        });
      }
    } catch (e) {
      setState(() {
        showSpinner = false;
      });
      print(e);
      final snackBar = SnackBar(content: Text(e.message));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void signInWithFacebook() async {
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
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashBoardLayout(),
            ));
      } else {
        print('Failed to sign in with Facebook. ');
      }
    });
  }

  Future<void> signInWithGoogle() async {
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
        context,
        MaterialPageRoute(
          builder: (context) => DashBoardLayout(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Scaffold(
      //resizeToAvoidBottomPadding: true,
      // resizeToAvoidBottomInset: true,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        color: foregroundColor,
        child: Stack(
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
                          "Login",
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
                              socialFunction: () {
                                signInWithFacebook();
                              }),
                          SocialIcon(
                              icon: FontAwesomeIcons.googlePlus,
                              color: Colors.red,
                              socialFunction: () {
                                signInWithGoogle();
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        decoration: KTextFieldDecoration.copyWith(
                          hintText: localization.translate("Enter your email."),
                        ),
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
                      Builder(
                        builder: (context) {
                          return RoundButton(
                              colour: foregroundColor,
                              title: localization.translate("Log In"),
                              onPressed: () {
                                submit();
                                login(context);
                              });
                        },
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgetpassword');
                        },
                        //color: Colors.lightBlue,
                        child: Text(
                          localization.translate("Forgot password?"),
                          style: TextStyle(color: backgroundColor2),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            localization.translate("Don't have an account?"),
                            style: TextStyle(fontSize: 16),
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: Text(
                              localization.translate("Sign up"),
                              style: TextStyle(
                                  fontSize: 18, color: foregroundColor),
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
      ),
    );
  }
}
