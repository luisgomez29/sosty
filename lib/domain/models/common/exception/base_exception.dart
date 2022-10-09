import 'package:sosty/domain/models/error_item/error_item.dart';

abstract class BaseException implements Exception {
  late ErrorItem _errorItem;

  BaseException(ErrorItem errorItem) {
    _errorItem = errorItem;
  }

  ErrorItem getError() => _errorItem;

  @override
  String toString() {
    final String codeStr = 'code: ${_errorItem.code}';
    final String domainStr = 'domain: ${_errorItem.domain}';
    final String messageStr = 'message: ${_errorItem.message}';
    final String reasonStr = 'reason: ${_errorItem.reason}';
    return '$codeStr - $domainStr - $messageStr - $reasonStr';
  }
}
