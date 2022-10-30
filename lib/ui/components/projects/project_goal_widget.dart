import 'package:flutter/material.dart';
import 'package:sosty/ui/components/general/custom_rich_text.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';

class ProjectGoalWidget extends StatelessWidget {
  const ProjectGoalWidget({
    Key? key,
    required this.amountOfCattles,
    required this.investmentRequired,
  }) : super(key: key);

  final String amountOfCattles;
  final String investmentRequired;

  @override
  Widget build(BuildContext context) {
    return CustomRichText(
      text: "Meta",
      textSpan:
          "$amountOfCattles Animales (${FormatterHelper.doubleFormat(investmentRequired)} Kg)",
    );
  }
}
