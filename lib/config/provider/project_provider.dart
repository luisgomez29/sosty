import 'package:flutter/material.dart';
import 'package:sosty/domain/use_cases/project/project_use_case.dart';

class ProjectProvider extends ChangeNotifier {
  final ProjectUseCase projectUseCase;

  ProjectProvider({required this.projectUseCase});
}
