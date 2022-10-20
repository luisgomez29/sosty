import 'package:sosty/domain/models/error_item/error_item.dart';

abstract class BaseException implements Exception {
  late ErrorItem _errorItem;

  BaseException(ErrorItem errorItem) {
    _errorItem = errorItem;
  }

  ErrorItem getError() => _errorItem;

  @override
  String toString() {
    return '''
      {
        "code": "${_errorItem.code}",
        "domain": "${_errorItem.domain}",
        "message": "${_errorItem.message}",
        "reason": "${_errorItem.reason}"
      }
     ''';
  }
}
