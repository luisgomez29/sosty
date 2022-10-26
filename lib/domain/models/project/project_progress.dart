import 'package:sosty/domain/models/project/project_progress_event.dart';
import 'package:sosty/domain/models/project/project_progress_weight.dart';

class ProjectProgress {
  ProjectProgress({
    required this.investmendId,
    required this.amountInvested,
    required this.projectName,
    required this.projectCode,
    required this.projectId,
    required this.investmentRequired,
    required this.investmentCollected,
    required this.projectProgres,
    required this.locationAddress,
    this.farmName,
    required this.locationState,
    this.locationCity,
    this.locationArrivalLIndications,
    required this.startDate,
    required this.endDate,
    this.cattleWeightAverageGain,
    this.initialWeight,
    this.finalWeight,
    required this.projectDuration,
    required this.totalProjectWeigthGain,
    this.amountOfCattles,
    required this.projectProfitability,
    required this.weights,
    required this.weightsList,
    required this.weightsDatesList,
    required this.firstName,
    required this.lastName,
    required this.contactEmail,
    required this.events,
  });

  final String investmendId;
  final int amountInvested;
  final String projectName;
  final String projectCode;
  final String projectId;
  final int investmentRequired;
  final double investmentCollected;
  final String projectProgres;
  final String locationAddress;
  final String? farmName;
  final String locationState;
  final String? locationCity;
  final String? locationArrivalLIndications;
  final DateTime startDate;
  final DateTime endDate;
  final int? cattleWeightAverageGain;
  final int? initialWeight;
  final int? finalWeight;
  final String projectDuration;
  final int totalProjectWeigthGain;
  final int? amountOfCattles;
  final double projectProfitability;
  final List<ProjectProgressWeight> weights;
  final List<int> weightsList;
  final List<String> weightsDatesList;
  final String firstName;
  final String lastName;
  final String contactEmail;
  final List<ProjectProgressEvent> events;

  factory ProjectProgress.fromJson(Map<String, dynamic> json) =>
      ProjectProgress(
        investmendId: json["investmendID"],
        amountInvested: json["amountInvested"],
        projectName: json["projectName"],
        projectCode: json["projectCode"],
        projectId: json["projectID"],
        investmentRequired: json["investmentRequired"],
        investmentCollected: json["investmentCollected"].toDouble(),
        projectProgres: json["projectProgres"],
        locationAddress: json["locationAddress"],
        farmName: json["farmName"],
        locationState: json["locationState"],
        locationCity: json["locationCity"],
        locationArrivalLIndications: json["locationArrivalLIndications"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        cattleWeightAverageGain: json["cattleWeightAverageGain"],
        initialWeight: json["initialWeight"],
        finalWeight: json["finalWeight"],
        projectDuration: json["projectDuration"],
        totalProjectWeigthGain: json["totalProjectWeigthGain"],
        amountOfCattles: json["amountOfCattles"],
        projectProfitability: json["projectProfitability"].toDouble(),
        weights: List<ProjectProgressWeight>.from(
          json["weights"].map((x) => ProjectProgressWeight.fromJson(x)),
        ),
        weightsList: List<int>.from(
          json["weightsList"].map((x) => x),
        ),
        weightsDatesList: List<String>.from(
          json["weightsDatesList"].map((x) => x),
        ),
        firstName: json["firstName"],
        lastName: json["lastName"],
        contactEmail: json["contactEmail"],
        events: List<ProjectProgressEvent>.from(
          json["events"].map((x) => ProjectProgressEvent.fromJson(x)),
        ),
      );
}
