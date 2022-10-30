import 'package:flutter/material.dart';

class ProjectProgressIndicator extends StatelessWidget {
  const ProjectProgressIndicator({
    Key? key,
    required this.progress,
  }) : super(key: key);

  final String progress;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: (double.parse(progress) / 100),
      minHeight: 5,
      semanticsLabel: 'Progreso',
    );
  }
}
