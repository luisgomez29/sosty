import 'package:flutter/material.dart';

class SelectTextFormField extends StatefulWidget {
  const SelectTextFormField({
    Key? key,
    required this.options,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  final List<String> options;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?>? onSaved;

  @override
  State<SelectTextFormField> createState() => _SelectTextFormFieldState();
}

class _SelectTextFormFieldState extends State<SelectTextFormField> {
  late String _currentSelectedValue;

  @override
  void initState() {
    super.initState();
    _currentSelectedValue = widget.options.first;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.validator,
      initialValue: _currentSelectedValue,
      onSaved: widget.onSaved,
      builder: (FormFieldState<String> state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InputDecorator(
            decoration: InputDecoration(
              hintText: 'Seleccione una opción',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              errorText: state.hasError ? state.errorText! : null,
            ),
            isEmpty: _currentSelectedValue == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _currentSelectedValue,
                isDense: true,
                onChanged: (String? newValue) {
                  setState(() {
                    _currentSelectedValue = newValue!;
                    state.didChange(newValue);
                  });
                },
                items: widget.options
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
