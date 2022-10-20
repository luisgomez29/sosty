import 'dart:typed_data';

/// Respuesta que devuelve la petición a las APIs
class ServiceResponse {
  /// Código de estado de la respuesta HTTP
  final int status;

  /// Cuerpo de la respuesta HTTP
  final String body;

  /// Cuerpo de la respuesta HTTP en bytes
  final Uint8List bodyBytes;

  ServiceResponse({
    required this.status,
    required this.body,
    required this.bodyBytes,
  });

  Map<String, Object?> toJson() => {
        'status': status,
        'body': body,
        'bodyBytes': bodyBytes,
      };
}
