import 'package:sosty/domain/models/common/exception/base_exception.dart';
import 'package:sosty/domain/models/error_item/error_item.dart';

class ApiException extends BaseException {
  ApiException(ErrorItem errorItem) : super(errorItem);
}
