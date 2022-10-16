import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    Key? key,
    required this.text,
    required this.textSpan,
    this.textStyle,
    this.textSpanStyle,
  }) : super(key: key);

  final String text;
  final String textSpan;
  final TextStyle? textStyle;
  final TextStyle? textSpanStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$text: ',
        style: textStyle ?? Styles.bodyText1Bold,
        children: <TextSpan>[
          TextSpan(
            text: textSpan,
            style: textSpanStyle ??
                Styles.bodyText1Bold.copyWith(
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}
