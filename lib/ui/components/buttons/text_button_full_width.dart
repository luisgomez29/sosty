import 'package:flutter/material.dart';

class TextButtonFullWidth extends StatelessWidget {
  const TextButtonFullWidth({
    Key? key,
    required this.text,
    required this.bgColor,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Color bgColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
