import 'package:flutter/material.dart';
import 'package:sosty/domain/use_cases/user/user_use_case.dart';

class UserProvider extends ChangeNotifier {

  final UserUseCase userUseCase;

  UserProvider({required this.userUseCase});
}
