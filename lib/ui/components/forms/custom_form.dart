import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({
    Key? key,
    required this.formKey,
    required this.children,
    this.padding,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: widget.padding ??
            const EdgeInsets.symmetric(
              horizontal: Styles.paddingContent,
            ),
        child: Column(
          children: widget.children,
        ),
      ),
    );
  }
}
