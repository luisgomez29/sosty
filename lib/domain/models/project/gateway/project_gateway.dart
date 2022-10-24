import 'package:sosty/domain/models/project/project_progress.dart';
import 'package:sosty/domain/models/project/project_item.dart';

abstract class ProjectGateway {
  Future<List<ProjectItem>> getAll();

  Future<ProjectProgress> getProjectProgressInformation(String investmentId);
}
