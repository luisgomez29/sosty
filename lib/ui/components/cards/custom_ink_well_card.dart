import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class CustomInkWellCard extends StatelessWidget {
  const CustomInkWellCard({
    Key? key,
    required this.child,
    this.navigator,
    this.margin,
    this.elevation,
    this.color,
    this.tintColor = false,
  }) : super(key: key);

  final Widget child;
  final bool? tintColor;
  final double? elevation;
  final double? margin;
  final Color? color;
  final VoidCallback? navigator;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      surfaceTintColor: tintColor == false ? Colors.white : null,
      child: navigator == null
          ? child
          : InkWell(
              child: child,
              borderRadius: BorderRadius.circular(10),
              onTap: navigator,
            ),
      elevation: elevation,
      margin: EdgeInsets.symmetric(vertical: margin ?? Styles.cardMargin),
    );
  }
}
