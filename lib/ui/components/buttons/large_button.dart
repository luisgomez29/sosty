import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.bgColor = primaryColor,
  }) : super(key: key);

  final String text;
  final Color bgColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
      style: TextButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(50),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonBorderRadius),
        ),
      ),
    );
  }
}
