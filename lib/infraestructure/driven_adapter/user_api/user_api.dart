import 'dart:convert';

import 'package:sosty_app/domain/models/user/gateway/user_gateway.dart';
import 'package:sosty_app/domain/models/user/user.dart';
import 'package:sosty_app/infraestructure/helpers/api_client/api_client.dart';
import 'package:sosty_app/infraestructure/helpers/maps/user/user_mapper.dart';

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
    Map<String, String> data = {'email': email, 'password': password};
    final response = await _apiClient
        .post("https://sosty-api.azurewebsites.net/api/User/Login", body: data);

    if (response.status == 200) {
      print("RESPONSE => ${response.body}");
      Map<String, dynamic> res = jsonDecode(response.body);
      return _userMapper.fromMap(res['user']);
    } else {
      print("DATA => ${response.body}");
      throw Exception('No se puede inciar sesión');
    }
  }
}
