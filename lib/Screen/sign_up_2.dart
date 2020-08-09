import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mo8tarib/Screen/edit_user.dart';
import 'package:mo8tarib/component/rounded_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:mo8tarib/component/social_icon.dart';
import 'package:mo8tarib/global.dart';
import 'package:mo8tarib/localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUp2 extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<SignUp2> {
  TextEditingController emailController;
  TextEditingController passwordController;
  String email;
  String password;

  double screenWidth, screenHeight;
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn = new GoogleSignIn();

  void signInWithEmail(
      String email, String password, BuildContext context) async {
    try {
      print(email);
      print(password);
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
//        Navigator.push(
//            context,
//            MaterialPageRoute(
//              builder: (context) => EditUser(email: email),
//            ));
        Navigator.pushNamed(context, '/addinf');
        setState(() {
          showSpinner = false;
        });
      }
    } catch (e) {
      setState(() {
        showSpinner = false;
      });
      print(e);
      final snackBar = SnackBar(content: Text('Email or Password are missid '));
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
        Navigator.pushNamed(context, '/edituser');
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
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => DashBoardLayout()));
    Navigator.pushNamed(context, '/edituser');
  }

  void submit() {
    setState(() {
      showSpinner = true;
    });
  }

  @override
  void initState() {
    emailController = TextEditingController(text: email);
    passwordController = TextEditingController(text: password);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    var localization = AppLocalizations.of(context);
    return Scaffold(
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
                              socialFunction: signInWithFacebook),
                          SocialIcon(
                              icon: FontAwesomeIcons.googlePlus,
                              color: Colors.red,
                              socialFunction: signInWithGoogle
                              //() {}
                              //  onGoogleSignIn
                              ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: emailController,
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
                        controller: passwordController,
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
                      Builder(builder: (context) {
                        return new RoundButton(
                            colour: foregroundColor,
                            title: localization.translate("Sign up"),
                            onPressed: () {
                              submit();
                              signInWithEmail(emailController.text,
                                  passwordController.text, context);
                            });
                      }),
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
