import 'package:flutter/material.dart';
import 'package:projeto_flutter_mylink/pages/cadastre.dart';
import 'package:projeto_flutter_mylink/pages/home.dart';
import 'package:projeto_flutter_mylink/pages/login.dart';
import 'package:projeto_flutter_mylink/routes/welcome.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (_) => const WelcomePage(),
        '/login': (_) => const LoginPage(),
        '/cadastre': (_) => const CadastrePage(),
        '/home': (_) => const HomePage(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}
