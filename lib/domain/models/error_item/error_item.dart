import 'dart:convert';

/// Error model
class ErrorItem {
  final String message;
  late final String reason;
  final String? code;
  final String? domain;

  ErrorItem({
    required this.message,
    required String reason,
    this.code,
    this.domain,
  }) {
    this.reason = utf8.decode(reason.toString().runes.toList());
  }
}
