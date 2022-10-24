import 'package:flutter/material.dart';
import 'package:sosty/domain/models/investment/investment_item.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/cards/custom_ink_well_card.dart';
import 'package:sosty/ui/components/general/custom_rich_text.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';
import 'package:sosty/ui/screens/projets/project_progress_screen.dart';

class InvestmentsCard extends StatelessWidget {
  const InvestmentsCard({
    Key? key,
    required this.investmentItem,
  }) : super(key: key);

  final InvestmentItem investmentItem;

  static const _sizedBoxValue = 7.0;

  /// Check if the total kilograms is greater than 0
  bool isTotalKilograms() {
    return investmentItem.investment.totalKilograms > 0;
  }

  String getKilogramsOrSostycs(String sostyUnit) {
    return isTotalKilograms() ? 'Kg' : sostyUnit;
  }

  double _getPercent() {
    return investmentItem.project.investmentCollected /
        investmentItem.project.investmentRequired;
  }

  String _getProgress() {
    final String percent = (_getPercent() * 100.0).toStringAsFixed(2);
    return '${investmentItem.project.investmentCollected.toStringAsFixed(2)} de '
        '${FormatterHelper.money(investmentItem.project.investmentRequired)} '
        '${getKilogramsOrSostycs('Sostycs')} ($percent%)';
  }

  String _getParticipation() {
    var participation = investmentItem.investment.totalUnits;
    if (isTotalKilograms()) {
      participation = investmentItem.investment.totalKilograms;
    }
    return "$participation ${getKilogramsOrSostycs('Sty')}";
  }

  String _getPercentage() {
    double percentage = (investmentItem.investment.totalUnits * 100) /
        investmentItem.project.investmentRequired;

    if (isTotalKilograms()) {
      percentage = (investmentItem.investment.totalKilograms * 100) /
          investmentItem.project.investmentCollected;
    }

    return "${FormatterHelper.doubleFormat(percentage)} %";
  }

  @override
  Widget build(BuildContext context) {
    final bool paymentConfirmed = investmentItem.investment.isConfirmed;
    return CustomInkWellCard(
      margin: 5.0,
      navigator: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectProgressScreen(
              investmentId: investmentItem.investment.investmendId,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              investmentItem.project.projectName,
              style: Styles.bodyText1Bold,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomRichText(
              text: "Código",
              textSpan: investmentItem.project.projectCode,
            ),
            const SizedBox(
              height: _sizedBoxValue,
            ),
            CustomRichText(
              text: "Productor",
              textSpan:
                  "${investmentItem.producer.firstName} ${investmentItem.producer.lastName}",
            ),
            const SizedBox(
              height: _sizedBoxValue,
            ),
            CustomRichText(
              text: "Progreso",
              textSpan: _getProgress(),
            ),
            const SizedBox(
              height: _sizedBoxValue,
            ),
            LinearProgressIndicator(
              value: _getPercent(),
              minHeight: 5,
              semanticsLabel: 'Progreso',
            ),
            const SizedBox(
              height: _sizedBoxValue,
            ),
            CustomRichText(
              text: "Monto invertido",
              textSpan: FormatterHelper.money(
                investmentItem.investment.amountInvested,
              ),
            ),
            const SizedBox(
              height: _sizedBoxValue,
            ),
            CustomRichText(
              text: "Porcentaje",
              textSpan: _getPercentage(),
            ),
            const SizedBox(
              height: _sizedBoxValue,
            ),
            CustomRichText(
              text: "Participación",
              textSpan: _getParticipation(),
            ),
            const SizedBox(
              height: _sizedBoxValue,
            ),
            CustomRichText(
              text: "Fecha de inversión",
              textSpan: FormatterHelper.shortDate(
                  investmentItem.investment.createDate),
            ),
            Row(
              children: [
                Text(
                  "Pago confirmado: ",
                  style: Styles.bodyText2Bold,
                ),
                Chip(
                  label: Text(paymentConfirmed ? 'SI' : "NO"),
                  backgroundColor: paymentConfirmed
                      ? Styles.primaryColor.withOpacity(0.1)
                      : Colors.deepOrange.withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: paymentConfirmed
                        ? Styles.primaryColor
                        : Colors.deepOrange.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Fase: ",
                  style: Styles.bodyText2Bold,
                ),
                Chip(
                  label: Text(investmentItem.project.projectStatus),
                  backgroundColor: const Color(0xFF82868B),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Ver seguimiento del proyecto',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
