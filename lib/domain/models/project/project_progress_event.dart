class ProjectProgressEvent {
  ProjectProgressEvent({
    required this.projectEventID,
    required this.projectID,
    this.projectWeightID,
    required this.eventType,
    required this.description,
    required this.eventDate,
    required this.createDate,
    this.deleteDate,
    this.picture1Url,
    this.picture2Url,
    this.picture3Url,
    this.picture4Url,
    this.picture5Url,
    this.file1Url,
    this.file2Url,
    this.file3Url,
  });

  final String projectEventID;
  final String projectID;
  final String? projectWeightID;
  final String eventType;
  final String description;
  final DateTime eventDate;
  final DateTime createDate;
  final DateTime? deleteDate;
  final String? picture1Url;
  final String? picture2Url;
  final String? picture3Url;
  final String? picture4Url;
  final String? picture5Url;
  final String? file1Url;
  final String? file2Url;
  final String? file3Url;

  factory ProjectProgressEvent.fromJson(Map<String, dynamic> json) =>
      ProjectProgressEvent(
        projectEventID: json['projectEventID'],
        projectID: json['projectID'],
        projectWeightID: json['projectWeightID'],
        eventType: json['eventType'],
        description: json['description'],
        eventDate: DateTime.parse(json['eventDate']),
        createDate: DateTime.parse(json['createDate']),
        deleteDate: json['deleteDate'] != null
            ? DateTime.parse(json['deleteDate'])
            : null,
        picture1Url: json['picture1Url'],
        picture2Url: json['picture2Url'],
        picture3Url: json['picture3Url'],
        picture4Url: json['picture4Url'],
        picture5Url: json['picture5Url'],
        file1Url: json['file1Url'],
        file2Url: json['file2Url'],
        file3Url: json['file3Url'],
      );
}
