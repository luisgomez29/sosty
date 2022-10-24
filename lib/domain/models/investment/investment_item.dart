import 'package:sosty/domain/models/investment/investment.dart';
import 'package:sosty/domain/models/producer/producer.dart';
import 'package:sosty/domain/models/project/project.dart';

class InvestmentItem {
  InvestmentItem({
    required this.producer,
    required this.project,
    required this.investment,
  });

  Producer producer;
  Project project;
  Investment investment;

  factory InvestmentItem.fromJson(Map<String, dynamic> json) => InvestmentItem(
        producer: Producer.fromJson(json["producer"]),
        project: Project.fromJson(json["project"]),
        investment: Investment.fromJson(json["investment"]),
      );
}
