import 'package:sosty/domain/use_cases/user/user_usecase.dart';
import 'package:sosty/infraestructure/driven_adapter/user_api/user_api.dart';

class UseCaseConfig {
  late UserApi _userApi;
  late UserUseCase userUseCase;

  UseCaseConfig() {
    _userApi = UserApi();
    userUseCase = UserUseCase(_userApi);
  }
}
