/// Mooelo de error
class ErrorItem {
  final String? code;
  final String? domain;
  final String message;
  final String reason;

  ErrorItem({
    this.code,
    this.domain,
    required this.message,
    required this.reason,
  });
}
