import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'file:///C:/Users/Digital/AndroidStudioProjects/Mo8tarib/lib/app/Screen/sign_in/model/email_sign_in_model.dart';
import 'package:mo8tarib/servies/auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth});
  final AuthBase auth;

  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();

  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();
  void dispose() {
    _modelController.close();
  }

  void updateWith(
      {String email,
      String password,
      EmailSignInformType formType,
      bool isLoaded,
      bool submitted}) {
    _model = _model.copyWith(
        email: email,
        password: password,
        formType: formType,
        isLoaded: isLoaded,
        submitted: submitted);
    _modelController.add(_model);
  }

  void toggleFormType() {
    updateWith(
      email: '',
      password: '',
      formType: _model.formType == EmailSignInformType.signIn
          ? EmailSignInformType.register
          : EmailSignInformType.signIn,
      submitted: false,
      isLoaded: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);

  Future<void> submit() async {
    updateWith(submitted: true, isLoaded: true);
    try {
      if (_model.formType == EmailSignInformType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(
            _model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoaded: false);
      rethrow;
    }
  }
}
