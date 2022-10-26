import 'package:sosty/ui/common/constants/constants.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';

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
  static String lastNameRequired = "Los apellidos son requeridos";

  // Cellphone
  static String cellPhoneRequired = "El celular es requerido";
  static String cellPhoneInvalid = "El celular no es valido";

  // City
  static String cityRequired = "La ciudad es requerida";

  // Message
  static String messageRequired = "El mensaje es requerido";

  // Investment participation
  static String minimumInvestmentRequired =
      "Inversión minima de ${FormatterHelper.money(Constants.minimumInvestment)}";

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
