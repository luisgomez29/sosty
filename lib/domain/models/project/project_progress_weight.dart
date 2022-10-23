class ProjectProgressWeight {
  ProjectProgressWeight({
    required this.projectWeightId,
    required this.projectId,
    required this.pesoManada,
    required this.cantidadDeAnimalesGanananDe0A7,
    required this.cantidadDeAnimalesGanananDe7A10,
    required this.cantidadDeAnimalesGanananMasDe10,
    required this.weightDate,
    required this.createDate,
    this.deleteDate,
  });

  final String projectWeightId;
  final String projectId;
  final int pesoManada;
  final int cantidadDeAnimalesGanananDe0A7;
  final int cantidadDeAnimalesGanananDe7A10;
  final int cantidadDeAnimalesGanananMasDe10;
  final DateTime weightDate;
  final DateTime createDate;
  final DateTime? deleteDate;

  factory ProjectProgressWeight.fromJson(Map<String, dynamic> json) => ProjectProgressWeight(
        projectWeightId: json["projectWeightID"],
        projectId: json["projectID"],
        pesoManada: json["pesoManada"],
        cantidadDeAnimalesGanananDe0A7: json["cantidadDeAnimalesGanananDe0a7"],
        cantidadDeAnimalesGanananDe7A10:
            json["cantidadDeAnimalesGanananDe7a10"],
        cantidadDeAnimalesGanananMasDe10:
            json["cantidadDeAnimalesGanananMasDe10"],
        weightDate: DateTime.parse(json["weightDate"]),
        createDate: DateTime.parse(json["createDate"]),
        deleteDate: json["deleteDate"] != null
            ? DateTime.parse(json["deleteDate"])
            : null,
      );
}
