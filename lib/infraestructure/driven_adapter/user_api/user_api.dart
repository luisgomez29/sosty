import 'package:sosty_app/domain/models/user/gateway/user_gateway.dart';
import 'package:sosty_app/domain/models/user/user.dart';
import 'package:sosty_app/infraestructure/helpers/api_client/api_client.dart';
import 'package:sosty_app/infraestructure/helpers/maps/user/user_mapper.dart';

class UserApi extends UserGateway {
  UserMapper _userMapper = UserMapper();
  ApiClient _apiClient = ApiClient();

  @override
  Future<User> getByID(String userID) {
    // final response = await _apiClient.get(service);
    // TODO: implement getByID
    throw UnimplementedError();
  }
}
