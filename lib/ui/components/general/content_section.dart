import 'package:flutter/material.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({
    Key? key,
    required this.child,
    required this.offsetY,
    this.paddingH,
  }) : super(key: key);

  final Widget child;
  final double offsetY;
  final double? paddingH;

  static const padding = 30.0;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, offsetY),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingH ?? padding),
        child: child,
      ),
    );
  }
}
