import 'package:flutter/material.dart';
import 'package:projeto_flutter_mylink/errors/login.error.dart';
import 'package:projeto_flutter_mylink/pages/home.dart';
import 'package:projeto_flutter_mylink/repositories/login.repository.dart';
import 'package:projeto_flutter_mylink/view-models/loginmodel.dart';

class LoginController {
  late LoginRepository repository;

  LoginController() {
    repository = LoginRepository();
  }

  Future login(LoginViewModel model, context) async {
    var login = await repository.login(model);

    if (login == true) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackbarloginError);
    }
  }
}
