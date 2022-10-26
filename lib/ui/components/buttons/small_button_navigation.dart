import 'package:flutter/material.dart';

class SmallButtonNavigation extends StatelessWidget {
  const SmallButtonNavigation({
    Key? key,
    required this.buttonText,
    required this.page,
    this.textStyle,
  }) : super(key: key);

  final String buttonText;
  final Widget page;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Text(
        buttonText,
        style: textStyle,
      ),
    );
  }
}
