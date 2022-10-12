class FormValidations {
  static isEmpty(value) {
    if (value == null || value.isEmpty) {
      return true;
    }
    return false;
  }

  static isEmailValid(String value) {
    String exp =
        r'^(([^<>()\[\]\\.,;:\s@”]+(\.[^<>()\[\]\\.,;:\s@”]+)*)|(“.+”))@((\[[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}])|(([a-zA-Z\-0–9]+\.)+[a-zA-Z]{2,}))$';
    return RegExp(exp).hasMatch(value);
  }

  static isMaxLengthValid(String value, int length) {
    return (value.length <= length) ? true : false;
  }

  static isMinLengthValid(String value, int length) {
    return (value.length >= length) ? true : false;
  }

  static isCellPhoneValid(String value) {
    String exp = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    return RegExp(exp).hasMatch(value);
  }
}
