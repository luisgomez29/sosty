import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.child,
    this.margin,
    this.tintColor = false,
    this.elevation,
    this.color,
    this.navigator,
  }) : super(key: key);

  final Widget child;
  final bool? tintColor;
  final double? elevation;
  final double? margin;
  final Color? color;
  final void Function()? navigator;

  static const defaultMargin = 8.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      surfaceTintColor: tintColor == false
          ? Colors.white
          : CardTheme.of(context).surfaceTintColor,
      child: navigator == null
          ? child
          : InkWell(
              child: child,
              borderRadius: BorderRadius.circular(10),
              onTap: navigator,
            ),
      elevation: elevation ?? CardTheme.of(context).elevation,
      margin: EdgeInsets.symmetric(vertical: margin ?? defaultMargin),
    );
  }
}
