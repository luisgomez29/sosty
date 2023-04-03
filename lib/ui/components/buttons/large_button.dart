import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/general/loading_indicator.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.bgColor,
    this.icon,
    this.textStyle,
    this.isLoading = false,
  }) : super(key: key);

  final String text;
  final Color? bgColor;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool? isLoading;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: bgColor ?? Styles.primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(50),
        textStyle: textStyle ?? Styles.headline3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Styles.buttonBorderRadius),
        ),
      ),
      child: isLoading!
          ? const LoadingIndicator()
          : Row(
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
    );
  }
}
