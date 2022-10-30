import 'package:flutter/material.dart';

class SmallButtonNavigation extends StatelessWidget {
  const SmallButtonNavigation({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.textStyle,
  }) : super(key: key);

  final String buttonText;
  final TextStyle? textStyle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: textStyle,
      ),
    );
  }
}
