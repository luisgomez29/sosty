import 'package:flutter/material.dart';
import 'package:sosty/domain/models/item/item.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/cards/custom_ink_well_card.dart';
import 'package:sosty/ui/components/general/custom_rich_text.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';
import 'package:sosty/ui/screens/investments/investments_detail_screen.dart';

class InvestmentsCard extends StatelessWidget {
  const InvestmentsCard({
    Key? key,
    required this.investment,
  }) : super(key: key);

  final Item investment;

  static const _sizedBoxValue = 7.0;

  double _getPercent(double investmentCollected, int investmentRequired) {
    return investmentCollected / investmentRequired;
  }

  String _getProgress(double investmentCollected, int investmentRequired) {
    final String percent =
        (_getPercent(investmentCollected, investmentRequired) * 100.0)
            .toStringAsFixed(2);
    return '${investmentCollected.toStringAsFixed(2)} de '
        '${FormatterHelper.money(investmentRequired)} Kg ($percent%)';
  }

  @override
  Widget build(BuildContext context) {
    final bool paymentConfirmed = investment.investment.isConfirmed;
    return CustomInkWellCard(
      navigator: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InvestmentsDetail(),
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
              investment.project.projectName,
              style: Styles.bodyText1Bold,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomRichText(
              text: "Código",
              textSpan: investment.project.projectCode,
            ),
            const SizedBox(
              height: _sizedBoxValue,
            ),
            CustomRichText(
              text: "Productor",
              textSpan:
                  "${investment.producer.firstName} ${investment.producer.lastName}",
            ),
            const SizedBox(
              height: _sizedBoxValue,
            ),
            CustomRichText(
              text: "Progreso",
              textSpan: _getProgress(
                investment.project.investmentCollected,
                investment.project.investmentRequired,
              ),
            ),
            const SizedBox(
              height: _sizedBoxValue,
            ),
            LinearProgressIndicator(
              value: _getPercent(
                investment.project.investmentCollected,
                investment.project.investmentRequired,
              ),
              minHeight: 5,
              semanticsLabel: 'Progreso',
            ),
            const SizedBox(
              height: _sizedBoxValue,
            ),
            CustomRichText(
              text: "Monto invertido",
              textSpan: FormatterHelper.money(
                investment.investment.amountInvested,
              ),
            ),
            const SizedBox(
              height: _sizedBoxValue,
            ),
            CustomRichText(
              text: "Participación",
              textSpan: "${investment.investment.totalKilograms} Kg",
            ),
            const SizedBox(
              height: _sizedBoxValue,
            ),
            CustomRichText(
              text: "Fecha de inversión",
              textSpan: FormatterHelper.date(investment.investment.createDate),
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
                  label: Text(investment.project.projectStatus),
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
