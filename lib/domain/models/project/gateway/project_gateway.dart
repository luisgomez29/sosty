import 'package:sosty/domain/models/project/project_item.dart';

abstract class ProjectGateway{
  Future<List<ProjectItem>> getAll();
}