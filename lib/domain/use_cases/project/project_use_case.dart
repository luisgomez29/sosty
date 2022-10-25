import 'package:sosty/domain/models/project/gateway/project_gateway.dart';
import 'package:sosty/domain/models/project/project_item.dart';
import 'package:sosty/domain/models/project/project_progress.dart';

class ProjectUseCase {
  final ProjectGateway _projectGateway;

  ProjectUseCase(this._projectGateway);

  Future<List<ProjectItem>> getAll() {
    return _projectGateway.getAll();
  }

  Future<ProjectProgress> getProjectProgressInformation(
    String investmentId,
  ) async {
    return _projectGateway.getProjectProgressInformation(investmentId);
  }

  Future<ProjectItem> getProjectPublicByCode(String projectCode) async {
    return _projectGateway.getProjectPublicByCode(projectCode);
  }
}
