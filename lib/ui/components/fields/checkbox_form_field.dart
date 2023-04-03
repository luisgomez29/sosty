import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    Key? key,
    required Widget title,
    required FormFieldSetter<bool> onSaved,
    required FormFieldValidator<bool> validator,
    bool initialValue = false,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<bool> state) {
            return CheckboxListTile(
              dense: true,
              title: title,
              value: state.value,
              checkColor: Colors.white,
              activeColor: Styles.primaryColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Styles.buttonBorderRadius),
              ),
              checkboxShape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(Styles.checkboxBorderRadius),
              ),
              onChanged: state.didChange,
              subtitle: state.hasError
                  ? Builder(
                      builder: (BuildContext context) => Text(
                        state.errorText!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    )
                  : null,
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        );
}
