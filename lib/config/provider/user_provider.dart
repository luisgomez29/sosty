import 'package:flutter/material.dart';
import 'package:sosty/domain/use_cases/user/user_usecase.dart';

class UserProvider extends ChangeNotifier {

  final UserUseCase userUseCase;

  UserProvider({required this.userUseCase});
}
