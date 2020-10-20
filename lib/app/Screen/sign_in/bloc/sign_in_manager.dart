import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/servies/auth.dart';

class SignInManager {
  SignInManager({@required this.isLoading, @required this.auth});
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;
  //to disable other buttons when process of the signIn Method

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<User> signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);
  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);
  Future<User> signInWithFaceBook() async =>
      await _signIn(auth.signInWithFaceBook);
}
