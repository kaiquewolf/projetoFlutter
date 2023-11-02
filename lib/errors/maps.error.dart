import 'package:flutter/material.dart';

const snackbarmapsError = SnackBar(
  content: Text(
    'Por favor para ter uma melhor experiência com nosso app, verifique se permitiiu a localização ou se está desativada!',
    textAlign: TextAlign.center,
    style: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  backgroundColor: Colors.lightGreen,
  duration: Duration(seconds: 30),
);
