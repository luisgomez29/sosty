import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosty/domain/use_cases/user/user_use_case.dart';
import 'package:sosty/infraestructure/driven_adapter/user_api/user_api.dart';

final userProvider = Provider<UserUseCase>((ref) {
  return UserUseCase(UserApi());
});
