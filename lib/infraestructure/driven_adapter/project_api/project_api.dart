import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosty/config/api/api_endpoint.dart';
import 'package:sosty/ui/common/enums/shared_preferences_enum.dart';
import 'package:sosty/domain/models/error_item/error_item.dart';
import 'package:sosty/domain/models/project/gateway/project_gateway.dart';
import 'package:sosty/domain/models/project/project_item.dart';
import 'package:sosty/domain/models/project/project_progress.dart';
import 'package:sosty/infraestructure/driven_adapter/project_api/errors/project_api_error.dart';
import 'package:sosty/infraestructure/helpers/api_client/api_client.dart';
import 'package:sosty/infraestructure/helpers/api_client/exception/api_exception.dart';

class ProjectApi extends ProjectGateway {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<List<ProjectItem>> getAll() async {
    final response = await _apiClient.get(
      ApiEndpoint.publicProjects,
    );

    if (response.status == HttpStatus.ok) {
      return List<ProjectItem>.from(
        jsonDecode(response.body).map((x) => ProjectItem.fromJson(x)),
      );
    } else {
      throw ApiException(
        ErrorItem(
          domain: ApiEndpoint.publicProjects,
          reason: response.body,
          message: ProjectApiError.getAllFailed,
        ),
      );
    }
  }

  @override
  Future<ProjectProgress> getProjectProgressInformation(
      String investmentId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken =
        prefs.getString(SharedPreferencesEnum.accessToken.value) ??
            SharedPreferencesEnum.keyNotFound.value;

    final response = await _apiClient.get(
      ApiEndpoint.getProjectProgressInformation,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
      params: {'investmendID': investmentId},
    );

    if (response.status == HttpStatus.ok) {
      return ProjectProgress.fromJson(jsonDecode(response.body));
    } else {
      throw ApiException(
        ErrorItem(
          domain: ApiEndpoint.getProjectProgressInformation,
          reason: response.body,
          message: ProjectApiError.progressInformationFailed,
        ),
      );
    }
  }
}
