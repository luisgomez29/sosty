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
  Future<User> getUserByID(String userId) async {
    final response = await _apiClient.get(
      ApiEndpoint.getUserById,
      params: {'userID': userId},
    );

    if (response.status == HttpStatus.ok) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw ApiException(
        ErrorItem(
          domain: ApiEndpoint.getUserById,
          reason: response.body,
          message: UserApiError.getUserByIdFailed,
        ),
      );
    }
  }

  @override
  Future<User> login(String email, String password) async {
    final response = await _apiClient.post(
      ApiEndpoint.login,
      body: {'email': email, 'password': password},
    );

    if (response.status == HttpStatus.ok) {
      return User.fromJson(jsonDecode(response.body));
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

  @override
  Future<User> signup(
    String email,
    String password,
    String userType,
    String firstName,
    String lastName,
    String phoneNumber,
  ) async {
    final response = await _apiClient.post(
      ApiEndpoint.signup,
      body: {
        'email': email,
        'password': password,
        'userType': userType,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
      },
    );

    if (response.status == HttpStatus.ok) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw ApiException(
        ErrorItem(
          domain: ApiEndpoint.signup,
          reason: response.body,
          message: UserApiError.signupFailed,
        ),
      );
    }
  }
}
