class ValidationMessages {
  ValidationMessages._();

  // Email
  static String emailRequired = "El email es requerido";
  static String emailInvalid = "El email no es valido";

  // Password
  static String passwordRequired = "La contraseña es requerida";
  static String passwordMinLengthInvalid = "La constraseña es muy corta";
  static String passwordMaxLengthInvalid = "La constraseña es muy larga";

  // Name
  static String firstNameRequired = "El nombre es requerido";

  // LastName
  static String lastNameRequired = "El apellido es requerido";

  // Cellphone
  static String cellPhoneRequired = "El celular es requerido";
  static String cellPhoneInvalid = "El celular no es valido";

  // General
  static const String termsAndConditionsRequired =
      "Debes aceptar la politica de privacidad y los temrinos y condiciones";

  static String fieldMinLength(int length) {
    return "Valor mínimo $length caracteres";
  }

  static String fieldMaxLength(int length) {
    return "Valor máximo $length caracteres";
  }
}
