import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.prefixIcon,
    required this.inputType,
    this.validator,
    this.controller,
    this.onChanged,
    this.maxLines,
    this.inputFormatters,
  }) : super(key: key);

  final String labelText;
  final Icon prefixIcon;
  final TextInputType inputType;
  final int? maxLines;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: inputType,
        validator: validator,
        controller: controller,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
