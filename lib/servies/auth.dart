import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<User> signInWithGoogle();
  Future<User> signInWithFaceBook();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(
      uid: user.uid,
      displayName: user.displayName,
      photoUrl: user.photoUrl,
    );
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    if (googleSignIn.isSignedIn() != null) {
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        googleSignIn.signInSilently(suppressErrors: false);
        final googleAuth = await googleSignInAccount.authentication;
        if (googleAuth.idToken != null && googleAuth.accessToken != null) {
          final authResult = await _firebaseAuth.signInWithCredential(
              GoogleAuthProvider.getCredential(
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
  Future<User> signInWithFaceBook() async {
    final faceBookLogIn = FacebookLogin();
    final result = await faceBookLogIn.logInWithReadPermissions(
      ['public_profile', 'email'],
    );

    print(result.status);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        if (result.accessToken != null) {
          print(result.accessToken.userId);
          try {
            final authResult = await _firebaseAuth
                .signInWithCredential(FacebookAuthProvider.getCredential(
              accessToken: result.accessToken.token,
            ));
//            final graphResponse = await http.get(
//                'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${result.accessToken}');
//            final profile = JSON.jsonDecode(graphResponse.body);
//            print("${profile.toString()}" + "  //////////    ");

            print(authResult.user);
            if (authResult.additionalUserInfo.isNewUser) {
              print("yes new user");
            } else {
              print("no");
            }
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
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> createUserWithEmailAndPassword(
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
