import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosty/domain/use_cases/investment/investment_use_case.dart';
import '../../infraestructure/driven_adapter/investment_api/investment_api.dart';

final investmentProvider = Provider<InvestmentUseCase>(
  (ref) {
    return InvestmentUseCase(InvestmentApi());
  },
);
