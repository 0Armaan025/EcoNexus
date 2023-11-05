import 'package:flutter/material.dart';

import '../models/user.dart';
import '../repositories/auth_repository.dart';

class AuthController {
  void signUp(BuildContext context, UserModel model) {
    AuthRepository repo = AuthRepository();

    repo.signUp(context, model);
  }

  void logIn(BuildContext context, String email, String password) {
    AuthRepository repo = AuthRepository();

    repo.logIn(context, email, password);
  }
}
