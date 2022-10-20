import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.bgColor = Styles.primaryColor,
    this.icon,
  }) : super(key: key);

  final String text;
  final Color bgColor;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon),
          SizedBox(
            width: icon != null ? 5 : 0,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
          ),
        ],
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
          borderRadius: BorderRadius.circular(Styles.buttonBorderRadius),
        ),
      ),
    );
  }
}
