import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/email_sign_in_model.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/services/auth.dart';

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
      bool submitted,
      bool isNew}) {
    _model = _model.copyWith(
        email: email,
        password: password,
        formType: formType,
        isLoaded: isLoaded,
        submitted: submitted,
        isNew: isNew);
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
      isNew: _model.formType == EmailSignInformType.signIn ? false : true,
    );
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);

  Future<MyUser> submit() async {
    updateWith(submitted: true, isLoaded: true);
    try {
      if (_model.formType == EmailSignInformType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
        updateWith(submitted: true, isLoaded: true, isNew: false);
      } else {
        final user = await auth.createUserWithEmailAndPassword(
            _model.email, _model.password);
        updateWith(submitted: true, isLoaded: true, isNew: true);
        return user;
      }
    } catch (e) {
      updateWith(isLoaded: false);
      rethrow;
    }
  }
}
