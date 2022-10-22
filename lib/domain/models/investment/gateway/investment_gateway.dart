import 'package:sosty/domain/models/item/item.dart';

abstract class InvestmentGateway {
  Future<List<Item>> getInvestmentsInProgressByInvestor(String investorId);
}
