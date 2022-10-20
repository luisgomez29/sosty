import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/cards/custom_card.dart';
import 'package:sosty/ui/components/general/custom_rich_text.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';
import 'package:sosty/ui/screens/investments/investments_detail.dart';

class InvestmentsCard extends StatelessWidget {
  const InvestmentsCard({
    Key? key,
    required this.title,
    required this.code,
    required this.location,
    required this.progress,
    required this.progressIndicator,
    required this.investedAmount,
    required this.participation,
    required this.paymentConfirmed,
    required this.investmentDate,
    required this.phase,
  }) : super(key: key);

  final String title;
  final String code;
  final String location;
  final String progress;
  final double progressIndicator;
  final String investedAmount;
  final double participation;
  final DateTime investmentDate;
  final bool paymentConfirmed;
  final String phase;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
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
              title,
              style: Styles.bodyText1Bold,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_pin,
                  color: Theme.of(context).primaryColor,
                ),
                Expanded(
                  child: Text(
                    location,
                    style: Styles.bodyText1,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            CustomRichText(
              text: "Código",
              textSpan: code,
            ),
            const SizedBox(
              height: 7,
            ),
            CustomRichText(
              text: "Progreso",
              textSpan: progress,
            ),
            const SizedBox(
              height: 7,
            ),
            LinearProgressIndicator(
              value: progressIndicator,
              minHeight: 5,
              semanticsLabel: 'Progreso',
            ),
            const SizedBox(
              height: 7,
            ),
            CustomRichText(
              text: "Monto invertido",
              textSpan: investedAmount,
            ),
            const SizedBox(
              height: 7,
            ),
            CustomRichText(
              text: "Participación",
              textSpan: "$participation Kg",
            ),
            const SizedBox(
              height: 7,
            ),
            CustomRichText(
              text: "Fecha de inversión",
              textSpan: FormatterHelper.date(investmentDate),
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
                  label: Text(phase),
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
