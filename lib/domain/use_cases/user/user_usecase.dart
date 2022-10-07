import 'package:sosty_app/domain/models/user/gateway/user_gateway.dart';
import 'package:sosty_app/domain/models/user/user.dart';

class UserUseCase {
  final UserGateway _userGateway;

  UserUseCase(this._userGateway);

  Future<User> getByID(String userID) async {
    return _userGateway.getByID(userID);
  }

  Future<User> login(String email, String password) async {
    return _userGateway.login(email, password);
  }
}
