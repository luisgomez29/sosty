import '../user.dart';

abstract class UserGateway {
  Future<User> getByID(String userID);
}
