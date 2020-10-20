abstract class StringValidator {
  bool isValid(String value);
}

class NoEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class EmailPasswordValidator {
  final StringValidator emailValidator = NoEmptyStringValidator();
  final StringValidator passwordValidator = NoEmptyStringValidator();
  final String emailError = 'Email Can\'t be empty ';
  final String passwordError = 'Password Can\'t be empty ';
}
