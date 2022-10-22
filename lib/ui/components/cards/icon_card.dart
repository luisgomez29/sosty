import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/cards/custom_ink_well_card.dart';

class IconCard extends StatelessWidget {
  const IconCard({
    Key? key,
    required this.title,
    required this.subtitle,
    this.icon,
    this.titleSpan,
    this.tintColor = false,
    this.padding,
    this.elevation,
    this.margin,
    this.color,
  }) : super(key: key);

  final String title;
  final String? titleSpan;
  final String subtitle;
  final IconData? icon;
  final bool? tintColor;
  final double? padding;
  final double? elevation;
  final double? margin;
  final Color? color;

  static const defaultPadding = 8.0;

  @override
  Widget build(BuildContext context) {
    return CustomInkWellCard(
      tintColor: tintColor,
      elevation: elevation ?? CardTheme.of(context).elevation,
      margin: margin ?? CustomInkWellCard.defaultMargin,
      color: color,
      child: Padding(
        padding: padding != null
            ? EdgeInsets.all(padding!)
            : const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: ClipOval(
                child: Material(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Icon(
                      icon ?? Icons.paid_outlined,
                      size: 32,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Styles.bodyText1Bold.copyWith(
                    fontSize: 22.0,
                  ),
                ),
                if (titleSpan != null)
                  Text(
                    titleSpan!,
                    style: Styles.bodyText1Bold,
                  ),
                Text(
                  subtitle,
                  style: Styles.bodyText2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
