import 'package:flutter/material.dart';
import 'package:sosty/ui/components/general/custom_rich_text.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';

class ProjectCurrentWidget extends StatelessWidget {
  const ProjectCurrentWidget({
    Key? key,
    required this.investmentCollected,
    required this.investmentRequired,
    required this.amountOfCattles,
  }) : super(key: key);

  final String investmentCollected;
  final String investmentRequired;
  final String amountOfCattles;

  String _getPercentageCurrentAnimals() {
    final percentage =
        (double.parse(investmentCollected) / double.parse(investmentRequired)) *
            double.parse(amountOfCattles);
    return "${FormatterHelper.doubleFormat(percentage)} Animales (${FormatterHelper.doubleFormat(investmentCollected)}) Kg";
  }

  @override
  Widget build(BuildContext context) {
    return CustomRichText(
      text: "Actual",
      textSpan: _getPercentageCurrentAnimals(),
    );
  }
}
