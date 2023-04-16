import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosty/domain/use_cases/project/project_use_case.dart';
import 'package:sosty/infraestructure/driven_adapter/project_api/project_api.dart';

final projectProvider = Provider<ProjectUseCase>((ref) {
  return ProjectUseCase(ProjectApi());
});
