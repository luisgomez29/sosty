/// Modelo para enrolar un usuario en Contactabilidad
class User {
  /// Email del usuario
  final String? email;

  /// Contraseña del usuario
  final String? password;

  /// Tipo de usuario
  final String? userType;

  /// Nombre del usuario
  final String? firstName;

  /// Apellido del usuario
  final String? lastName;

  /// Numero de telefono del usuario
  final String? phoneNumber;

  /// Origin del registro
  final String? origin;


  User({
    required this.email,
    required this.password,
    required this.userType,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.origin
  });

  // Map<String, dynamic> toJson() => {
  //   'customerDocumentType': customerDocumentType,
  //   'customerDocumentNumber': customerDocumentNumber,
  //   'applicationProviderId': applicationProviderId,
  //   'deviceCode': deviceCode,
  //   'devicePlatform': devicePlatform,
  //   'customerName': customerName,
  //   'customerLastName': customerLastName,
  //   'customerNickname': customerNickname,
  //   'mdmKey': mdmKey,
  //   'topicName': topicName,
  //   'categoryIds': categoryIds,
  // };
}
