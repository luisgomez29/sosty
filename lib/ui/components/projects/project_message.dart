import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class ProjectMessage extends StatelessWidget {
  const ProjectMessage({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Text(
        text,
        style: Styles.bodyText1Bold.copyWith(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
