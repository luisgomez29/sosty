import 'package:sosty/domain/models/Item/item.dart';
import 'package:sosty/domain/models/investment/gateway/investment_gateway.dart';

class InvestmentUseCase {
  final InvestmentGateway _investmentGateway;

  InvestmentUseCase(this._investmentGateway);

  Future<List<Item>> getInvestmentsInProgressByInvestor(
    String investorID,
  ) async {
    return _investmentGateway.getInvestmentsInProgressByInvestor(investorID);
  }
}
