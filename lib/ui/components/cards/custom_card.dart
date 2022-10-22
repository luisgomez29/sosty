import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.child,
    this.padding,
    this.color,
    this.tintColor = false,
  }) : super(key: key);

  final Widget child;
  final Color? color;
  final bool? tintColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      surfaceTintColor: tintColor == false
          ? Colors.white
          : CardTheme.of(context).surfaceTintColor,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }
}
