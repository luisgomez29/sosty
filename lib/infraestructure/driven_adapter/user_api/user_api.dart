import 'dart:convert';
import 'dart:io';

import 'package:sosty/domain/models/error_item/error_item.dart';
import 'package:sosty/domain/models/user/gateway/user_gateway.dart';
import 'package:sosty/domain/models/user/user.dart';
import 'package:sosty/infraestructure/helpers/api_client/api_client.dart';
import 'package:sosty/infraestructure/helpers/api_client/exception/api_exception.dart';
import 'package:sosty/infraestructure/helpers/maps/user/user_mapper.dart';
import 'package:sosty/infraestructure/driven_adapter/user_api/errors/user_api_error.dart';

class UserApi extends UserGateway {
  final UserMapper _userMapper = UserMapper();
  final ApiClient _apiClient = ApiClient();

  @override
  Future<User> getByID(String userID) {
    // TODO: implement getByID
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    const url = "https://sosty-api.azurewebsites.net/api/User/Login";
    final response = await _apiClient.post(
      url,
      body: {'email': email, 'password': password},
    );

    if (response.status == HttpStatus.ok) {
      print("RESPONSE => ${response.body}");
      Map<String, dynamic> res = jsonDecode(response.body);
      return _userMapper.fromMap(res['user']);
    } else {
      print("DATA => ${response.body}");
      throw ApiException(
        ErrorItem(
          domain: url,
          reason: response.body,
          message: UserApiError.failedLogin,
        ),
      );
    }
  }
}
