import '../user.dart';

abstract class UserGateway {
  Future<User> getUserByID(String userId);

  Future<User> login(String email, String password);

  Future<User> signup(
    String email,
    String password,
    String userType,
    String firstName,
    String lastName,
    String phoneNumber,
  );
}
