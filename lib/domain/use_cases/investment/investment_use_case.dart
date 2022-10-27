import 'package:sosty/domain/models/investment/investment_item.dart';
import 'package:sosty/domain/models/investment/gateway/investment_gateway.dart';

class InvestmentUseCase {
  final InvestmentGateway _investmentGateway;

  InvestmentUseCase(this._investmentGateway);

  Future<List<InvestmentItem>> getInvestmentsInProgressByInvestor(
    String investorId,
  ) async {
    return _investmentGateway.getInvestmentsInProgressByInvestor(investorId);
  }

  Future<List<InvestmentItem>> getInvestmentsFinishedByInvestor(
    String investorId,
  ) async {
    return _investmentGateway.getInvestmentsFinishedByInvestor(investorId);
  }
}
