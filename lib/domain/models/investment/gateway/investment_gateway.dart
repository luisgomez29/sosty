import 'package:sosty/domain/models/investment/investment_item.dart';

abstract class InvestmentGateway {
  Future<List<InvestmentItem>> getInvestmentsInProgressByInvestor(
    String investorId,
  );
}
