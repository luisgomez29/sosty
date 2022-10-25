import 'package:flutter/material.dart';

class AlertBase extends StatelessWidget {
  const AlertBase({
    Key? key,
    required this.child,
    required this.surfaceTintColor,
    this.padding,
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
