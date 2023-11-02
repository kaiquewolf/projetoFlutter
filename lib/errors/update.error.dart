import 'package:flutter/material.dart';

const updatesnackBarError = SnackBar(
  content: Text(
    'Não foi possível atualizar o  cadastro!',
    textAlign: TextAlign.center,
  ),
  backgroundColor: Colors.redAccent,
);

const updatesnackBarSucceess = SnackBar(
  content: Text(
    'Atualizado com sucesso!',
    textAlign: TextAlign.center,
  ),
  backgroundColor: Colors.greenAccent,
);
