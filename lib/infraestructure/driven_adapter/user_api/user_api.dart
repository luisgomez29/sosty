import 'dart:convert';
import 'dart:io';

import 'package:sosty/config/api/api_endpoint.dart';
import 'package:sosty/domain/models/error_item/error_item.dart';
import 'package:sosty/domain/models/user/gateway/user_gateway.dart';
import 'package:sosty/domain/models/user/user.dart';
import 'package:sosty/infraestructure/driven_adapter/user_api/errors/user_api_error.dart';
import 'package:sosty/infraestructure/helpers/api_client/api_client.dart';
import 'package:sosty/infraestructure/helpers/api_client/exception/api_exception.dart';

class UserApi extends UserGateway {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<User> getByID(String userID) {
    // TODO: implement getByID
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    final response = await _apiClient.post(
      ApiEndpoint.login,
      body: {'email': email, 'password': password},
    );

    if (response.status == HttpStatus.ok) {
      Map<String, dynamic> res = jsonDecode(response.body);
      return User.fromJson(res);
    } else {
      throw ApiException(
        ErrorItem(
          domain: ApiEndpoint.login,
          reason: response.body,
          message: UserApiError.loginFailed,
        ),
      );
    }
  }
}
