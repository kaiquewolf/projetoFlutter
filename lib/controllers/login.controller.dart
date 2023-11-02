import 'package:flutter/material.dart';
import 'package:projeto_flutter_mylink/errors/login.error.dart';
import 'package:projeto_flutter_mylink/repositories/login.repository.dart';
import 'package:projeto_flutter_mylink/view-models/loginmodel.dart';

class LoginController {
  late LoginRepository repository;
  var model = LoginViewModel();

  LoginController() {
    repository = LoginRepository();
  }

  Future login(LoginViewModel model, context) async {
    var login = await repository.login(model);

    if (login == true) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/home");
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackbarloginError);
    }
  }
}
