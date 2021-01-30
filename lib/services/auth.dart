import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert' as JSON;

abstract class AuthBase {
  bool get isNewUser;
  Stream<MyUser> get onAuthStateChanged;
  Future<MyUser> currentUser();
  Future<MyUser> signInAnonymously();
  Future<MyUser> signInWithGoogle();
  Future<MyUser> signInWithFaceBook();
  Future<MyUser> signInWithEmailAndPassword(String email, String password);
  Future<MyUser> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  MyUser _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return MyUser(
      uid: user.uid,
      disPlayName: user.displayName,
      photoUrl: user.photoURL,
      email: user.email,
    );
  }

  bool newUser;
  @override
  bool get isNewUser {
    return newUser;
  }

  @override
  Stream<MyUser> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<MyUser> currentUser() async {
    final user =  _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<MyUser> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<MyUser> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    if (googleSignIn.isSignedIn() != null) {
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final googleAuth = await googleSignInAccount.authentication;
        if (googleAuth.idToken != null && googleAuth.accessToken != null) {
          final authResult = await _firebaseAuth.signInWithCredential(
              GoogleAuthProvider.credential(
                  idToken: googleAuth.idToken,
                  accessToken: googleAuth.accessToken));
          if (authResult.additionalUserInfo.isNewUser) {
            print("yes new user");
            //User logging in for the first time
            // Redirect user to tutorial
          } else {
            print("no");
            return _userFromFirebase(authResult.user);
            //Show user profile
          }
        } else {
          throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH',
            message: 'Missing Google Auth Token ',
          );
        }
      } else {
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'SIGN IN ABOURTED BY USER ',
        );
      }
    } else {
      print("yes it is");
    }
  }

  @override
  Future<MyUser> signInWithFaceBook() async {
    final faceBookLogIn = FacebookLogin();
    final result = await faceBookLogIn.logInWithReadPermissions(
      [
        "public_profile",
        "email",
      ],
    );

    print(result.status);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        if (result.accessToken != null) {
          print(result.accessToken.userId);
          try {
            final authResult = await _firebaseAuth
                .signInWithCredential(FacebookAuthProvider.credential(
     result.accessToken.token,
            ));
//            final graphResponse = await http.get(
//                'https://graph.facebook.com/v2.12/me?fields=name,picture,email,gender&access_token=${result.accessToken.token}');
//            final profile = JSON.jsonDecode(graphResponse.body);
//
//            print("${profile['email'].toString()}" + "  //////////    ");

            newUser = authResult.additionalUserInfo.isNewUser;
            print(authResult.user.photoURL + " firebase user" + "$isNewUser");
            return _userFromFirebase(authResult.user);
          } catch (e) {
            print(e.toString());
          }
        } else {
          throw PlatformException(
              code: 'ERROR_ABORTED_BY_USER',
              message: 'sign in aborted by user');
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("cancelld by user");
        break;
      case FacebookLoginStatus.error:
        print("error");
        break;
    }
  }

  @override
  Future<MyUser> signInWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<MyUser> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      final faceBookLogIn = FacebookLogin();
      await faceBookLogIn.logOut();

      await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
