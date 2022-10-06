/// Respuesta que devuelve la petición a los los microservicios de
/// Contactabilidad
class ServiceResponse {
  /// Código de estado de la respuesta HTTP
  final int status;

  /// Cuerpo de la respuesta HTTP
  final String body;

  ServiceResponse({required this.status, required this.body});

  Map<String, Object?> toJson() => {'status': status, 'body': body};
}
