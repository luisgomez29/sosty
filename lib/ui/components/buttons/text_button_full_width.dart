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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextButton(
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
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
