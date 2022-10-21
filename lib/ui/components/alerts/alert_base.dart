import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class AlertBase extends StatelessWidget {
  const AlertBase({
    Key? key,
    required this.child,
    this.padding,
    required this.surfaceTintColor,
  }) : super(key: key);

  final Widget child;
  final Color surfaceTintColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: surfaceTintColor,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
