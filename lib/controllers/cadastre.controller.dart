// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'package:flutter/material.dart';
import 'package:projeto_flutter_mylink/errors/cadastre.error.dart';
import 'package:projeto_flutter_mylink/routes/welcome.dart';
import 'package:projeto_flutter_mylink/repositories/cadastre.repositoy.dart';
import 'package:projeto_flutter_mylink/view-models/cadastremodel.dart';

class CadastreController {
  late CadastreRepository repository;

  CadastreController() {
    repository = CadastreRepository();
  }

  Future register(CadastreViewModel model, BuildContext context) async {
    var register = await repository.register(model);

    if (register == true) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        ),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBarSucceessCadastre);
    } else {
      print("${register}");
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBarErrorCadastre);
    }
  }
}
