import 'package:flutter/material.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({
    Key? key,
    required this.formKey,
    required this.children,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final List<Widget> children;

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
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: widget.children,
        ),
      ),
    );
  }
}
