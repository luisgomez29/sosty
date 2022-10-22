import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/alerts/alert_base.dart';

class AlertWarning extends StatelessWidget {
  const AlertWarning({
    Key? key,
    required this.child,
    this.padding,
  }) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry? padding;

  static final Color textColor = Styles.warningColor.withOpacity(0.7);

  @override
  Widget build(BuildContext context) {
    return AlertBase(
      padding: padding,
      surfaceTintColor: Colors.red,
      child: child,
    );
  }
}
