import 'package:sosty_app/domain/models/common/exception/base_exception.dart';
import 'package:sosty_app/domain/models/error_item/error_item.dart';

class ApiException extends BaseException {
  ApiException(ErrorItem errorItem) : super(errorItem);
}
