import 'package:flutter/material.dart';
import 'package:projeto_flutter_mylink/pages/welcome.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const WelcomePage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
