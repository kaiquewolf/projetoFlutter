import 'package:flutter/material.dart';
import 'package:projeto_flutter_mylink/errors/update.error.dart';
import 'package:projeto_flutter_mylink/routes/welcome.dart';
import 'package:projeto_flutter_mylink/repositories/update.repository.dart';
import 'package:projeto_flutter_mylink/view-models/updatemodel.dart';

class UpdateController {
  late UpdateRepository repository;

  UpdateController() {
    repository = UpdateRepository();
  }

  Future update(UpdateViewModel model, BuildContext context) async {
    var update = await repository.update(model);

    if (update == true) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        ),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(updatesnackBarSucceess);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(updatesnackBarError);
    }
  }
}
