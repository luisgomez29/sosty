import '../user.dart';

abstract class UserGateway {
  Future<User> getByID(String userID);
  Future<User> login(String email, String password);
}
