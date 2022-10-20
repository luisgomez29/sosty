import 'package:flutter/material.dart';
import 'package:sosty/domain/use_cases/investment/investment_use_case.dart';

class InvestmentProvider extends ChangeNotifier {
  final InvestmentUseCase investmentUseCase;

  InvestmentProvider({required this.investmentUseCase});
}
