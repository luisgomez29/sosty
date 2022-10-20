import 'package:sosty/domain/models/investment/investment.dart';
import 'package:sosty/domain/models/producer/producer.dart';
import 'package:sosty/domain/models/project/project.dart';

class Item {
  Item({
    required this.producer,
    required this.project,
    required this.investment,
  });

  Producer producer;
  Project project;
  Investment investment;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        producer: Producer.fromJson(json["producer"]),
        project: Project.fromJson(json["project"]),
        investment: Investment.fromJson(json["investment"]),
      );
}
