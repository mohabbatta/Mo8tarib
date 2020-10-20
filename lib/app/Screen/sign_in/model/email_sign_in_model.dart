import 'package:mo8tarib/app/Screen/sign_in/validator.dart';

enum EmailSignInformType { signIn, register }

class EmailSignInModel with EmailPasswordValidator {
  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.formType = EmailSignInformType.signIn,
    this.isLoaded = false,
    this.submitted = false,
  });

  final String email;
  final String password;
  final EmailSignInformType formType;
  final bool isLoaded;
  final bool submitted;

  String get primaryButtonText {
    return formType == EmailSignInformType.signIn
        ? 'Sign In'
        : 'Create a new account';
  }

  String get secondButtonText {
    return formType == EmailSignInformType.signIn
        ? 'Need an Account? Register'
        : 'Have an account? Sign in';
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoaded;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? passwordError : null;
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? emailError : null;
  }

  EmailSignInModel copyWith(
      {String email,
      String password,
      EmailSignInformType formType,
      bool isLoaded,
      bool submitted}) {
    return EmailSignInModel(
        email: email ?? this.email,
        password: password ?? this.password,
        formType: formType ?? this.formType,
        isLoaded: isLoaded ?? this.isLoaded,
        submitted: submitted ?? this.submitted);
  }
}
