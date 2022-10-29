import 'package:flutter/material.dart';
import 'package:sosty/ui/components/general/custom_rich_text.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';

class ProjectHelper {
  ProjectHelper._();

  static String _getPercentageCurrentAnimals(String investmentCollected,
      String investmentRequired, String amountOfCattles) {
    final percentage =
        (double.parse(investmentCollected) / double.parse(investmentRequired)) *
            double.parse(amountOfCattles);
    return "${FormatterHelper.doubleFormat(percentage)} Animales (${FormatterHelper.doubleFormat(investmentCollected)}) Kg";
  }

  static CustomRichText getGoalWidget(
      String amountOfCattles, String investmentRequired) {
    return CustomRichText(
      text: "Meta",
      textSpan:
          "$amountOfCattles Animales (${FormatterHelper.doubleFormat(investmentRequired)} Kg)",
    );
  }

  static CustomRichText getCurrentWidget(
    String investmentCollected,
    String investmentRequired,
    String amountOfCattles,
  ) {
    return CustomRichText(
      text: "Actual",
      textSpan: _getPercentageCurrentAnimals(
        investmentCollected,
        investmentRequired,
        amountOfCattles,
      ),
    );
  }

  static LinearProgressIndicator getProgressIndicatorWidget(
      String projectProgress) {
    return LinearProgressIndicator(
      value: (double.parse(projectProgress) / 100),
      minHeight: 5,
      semanticsLabel: 'Progreso',
    );
  }
}
