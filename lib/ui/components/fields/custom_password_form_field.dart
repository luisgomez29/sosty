import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/common/validations/form_validations.dart';
import 'package:sosty/ui/common/validations/validation_messages.dart';

class CustomPasswordFormField extends StatefulWidget {
  const CustomPasswordFormField({
    Key? key,
    required this.labelText,
    required this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  final String labelText;
  final Icon prefixIcon;
  final Widget? suffixIcon;

  @override
  _CustomPasswordFormFieldState createState() =>
      _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  bool _isObscureText = true;

  _showHidePassword() {
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        obscureText: _isObscureText,
        validator: (value) {
          if (FormValidations.isEmpty(value!)) {
            return ValidationMessages.passwordRequired;
          }
          if (!FormValidations.isMinLengthValid(value, 6)) {
            return ValidationMessages.passwordMinLengthInvalid;
          }
          if (!FormValidations.isMaxLengthValid(value, 40)) {
            return ValidationMessages.passwordMaxLengthInvalid;
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          labelText: widget.labelText,
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: _showHidePassword,
            icon: Icon(
              _isObscureText ? Icons.visibility : Icons.visibility_off,
            ),
            style: IconButton.styleFrom(
              foregroundColor: secondaryColor.withOpacity(0.55),
            ),
          ),
        ),
      ),
    );
  }
}
