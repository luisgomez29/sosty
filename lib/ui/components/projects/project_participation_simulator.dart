import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sosty/ui/common/constants/constants.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/common/validations/form_validations.dart';
import 'package:sosty/ui/common/validations/validation_messages.dart';
import 'package:sosty/ui/components/alerts/alert_warning.dart';
import 'package:sosty/ui/components/cards/custom_card.dart';
import 'package:sosty/ui/components/fields/custom_text_form_field.dart';
import 'package:sosty/ui/components/forms/custom_form.dart';
import 'package:sosty/ui/helpers/formatter_helper.dart';
import 'package:sosty/ui/helpers/formatters/currency_formatter.dart';

class ProjectParticipationSimulator extends StatefulWidget {
  const ProjectParticipationSimulator({
    Key? key,
    required this.profitability,
    required this.duration,
  }) : super(key: key);

  final String profitability;
  final String duration;

  @override
  _ProjectParticipationSimulatorState createState() =>
      _ProjectParticipationSimulatorState();
}

class _ProjectParticipationSimulatorState
    extends State<ProjectParticipationSimulator> {
  late String _totalGain;
  late String _participationValue;
  late double _profitabilityPercentage;
  final _sizedBoxValue = 5.0;
  final _formKey = GlobalKey<FormState>();
  final _participationCtrl = TextEditingController();

  void _getProfitabilityPercentage() {
    final profitability = double.parse(widget.profitability) / 100;
    _profitabilityPercentage = (profitability / Constants.monthsOfYear) *
        double.parse(widget.duration);
  }

  void _getParticipation(String value) {
    final userInput = int.parse(value.replaceAll('.', ''));
    final result = _profitabilityPercentage * userInput;
    setState(() {
      _totalGain = FormatterHelper.money(userInput + result);
      _participationValue = FormatterHelper.money(result);
    });
  }

  @override
  void initState() {
    super.initState();
    _participationCtrl.text = FormatterHelper.doubleFormat(5000000);
    _getProfitabilityPercentage();
    _getParticipation(_participationCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    const double titleFontSize = 18.0;
    const double subtitleFontSize = 14.0;
    return CustomCard(
      child: Column(
        children: [
          Text(
            "Simula tu participación, digita el valor:",
            style: Styles.headline2.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            height: _sizedBoxValue * 2,
          ),
          CustomForm(
            formKey: _formKey,
            padding: const EdgeInsets.all(0.0),
            children: [
              CustomTextFormField(
                labelText: "",
                controller: _participationCtrl,
                inputType: TextInputType.number,
                prefixIcon: const Icon(
                  Icons.paid_outlined,
                ),
                validator: (value) {
                  if (FormValidations.isEmpty(value!)) {
                    return ValidationMessages.minimumInvestmentRequired;
                  }
                  if (int.parse(value.replaceAll('.', '')) <
                      Constants.minimumInvestment) {
                    return ValidationMessages.minimumInvestmentRequired;
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyFormatter(),
                ],
                onChanged: _getParticipation,
              ),
            ],
          ),
          SizedBox(
            height: _sizedBoxValue,
          ),
          AlertWarning(
            child: RichText(
              text: TextSpan(
                text: "Ganarás ",
                style: TextStyle(
                  color: AlertWarning.textColor,
                  fontSize: titleFontSize,
                ),
                children: [
                  TextSpan(
                    text: "$_participationValue COP, ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "en ",
                    style: Styles.bodyText1Bold.copyWith(
                      color: AlertWarning.textColor,
                    ),
                  ),
                  TextSpan(
                    text: "${widget.duration} Meses ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text:
                        "aproximadamente, equivalentes a una rentabilidad total estimada del ",
                  ),
                  TextSpan(
                    text:
                        "(${FormatterHelper.doubleFormat(_profitabilityPercentage * 100)}%).\n",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text: "\nRecibirás aproximadamente ",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  TextSpan(
                    text: "$_totalGain COP, ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: subtitleFontSize,
                    ),
                  ),
                  const TextSpan(
                    text: "al momento de liquidar el proyecto.",
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
