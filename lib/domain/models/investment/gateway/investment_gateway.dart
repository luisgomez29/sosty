import 'package:sosty/domain/models/Item/item.dart';

abstract class InvestmentGateway {
  Future<List<Item>> getInvestmentsInProgressByInvestor(String investorID);
}
