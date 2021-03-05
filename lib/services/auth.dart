import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
abstract class AuthBase {
  bool get isNewUser;
  set isNewUser(bool isNewUser);
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

  @override
  bool isNewUser;

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
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final googleAuth = await googleSignInAccount.authentication;
        if (googleAuth.accessToken != null&&googleAuth.idToken != null ) {
          final authResult = await _firebaseAuth.signInWithCredential(
              GoogleAuthProvider.credential(
                  idToken: googleAuth.idToken,
                  accessToken: googleAuth.accessToken));
           isNewUser = authResult.additionalUserInfo.isNewUser;
          return _userFromFirebase(authResult.user);
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
    }


  @override
  Future<MyUser> signInWithFaceBook() async {
    final faceBookLogIn = FacebookLogin();
    final result = await faceBookLogIn.logIn(
      ['public_profile'],
    );
    if (result.accessToken != null) {
      final authResult = await _firebaseAuth
          .signInWithCredential(FacebookAuthProvider.credential(
         result.accessToken.token,
      ));
      isNewUser = authResult.additionalUserInfo.isNewUser;
      return _userFromFirebase(authResult.user);
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'sign in aborted by user');
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
