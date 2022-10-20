import 'package:sosty/domain/models/user/gateway/user_gateway.dart';
import 'package:sosty/domain/models/user/user.dart';

class UserUseCase {
  final UserGateway _userGateway;

  UserUseCase(this._userGateway);

  Future<User> getUserByID(String userId) async {
    return _userGateway.getUserByID(userId);
  }

  Future<User> login(String email, String password) async {
    return _userGateway.login(email, password);
  }

  Future<User> signup(
    String email,
    String password,
    String userType,
    String firstName,
    String lastName,
    String phoneNumber,
  ) async {
    return _userGateway.signup(
      email,
      password,
      userType,
      firstName,
      lastName,
      phoneNumber,
    );
  }
}
