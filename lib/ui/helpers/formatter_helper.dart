import 'package:intl/intl.dart';

class FormatterHelper {
  FormatterHelper._();

  static String money(dynamic number) {
    var amount = 0;
    if (number != null) {
      if (number is int) {
        amount = number;
      } else if (number is String) {
        amount = int.parse(number);
      } else if (number is double) {
        return '\$${doubleFormat(number)}';
      }
    }
    final formatter = NumberFormat('###,###,###', 'es_CO');
    return '\$${formatter.format(amount)}';
  }

  static String doubleFormat(dynamic number) {
    var amount = 0.0;
    if (number != null) {
      if (number is int) {
        amount = number.toDouble();
      } else if (number is String) {
        amount = double.parse(number);
      } else if (number is double) {
        amount = number;
      }
    }
    final formatter = NumberFormat('###,###,###.##', 'es_CO');
    return formatter.format(amount);
  }

  static String shortDate(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }
}
