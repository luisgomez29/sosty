import 'package:flutter/services.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';

class CurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String newText = currencyFormat(newValue.text);
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }

  String currencyFormat(String value) {
    if (value.trim().isEmpty) return '';
    return FormatterHelper.doubleFormat(value.replaceAll('.', ''));
  }
}
