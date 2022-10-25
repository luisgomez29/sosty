import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.child,
    this.color,
    this.margin,
    this.padding,
    this.tintColor = false,
  }) : super(key: key);

  final Widget child;
  final Color? color;
  final bool? tintColor;
  final double? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      surfaceTintColor: tintColor == false ? Colors.white : null,
      margin: EdgeInsets.symmetric(vertical: margin ?? Styles.cardMargin),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(20.0),
        child: child,
      ),
    );
  }
}
