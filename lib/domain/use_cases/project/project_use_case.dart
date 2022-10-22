import 'package:sosty/domain/models/project/gateway/project_gateway.dart';
import 'package:sosty/domain/models/project/project_item.dart';
class ProjectUseCase{

  final ProjectGateway _projectGateway;

  ProjectUseCase(this._projectGateway);

  Future<List<ProjectItem>> getAll(){
    return _projectGateway.getAll();
  }

}