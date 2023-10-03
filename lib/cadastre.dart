import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class CadastrePage extends StatefulWidget {
  const CadastrePage({super.key});

  @override
  State<CadastrePage> createState() => _CadastrePageState();
}

class _CadastrePageState extends State<CadastrePage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: 20,
      ),
      child: Form(
        // key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(300),
              child: Text("Nome"),
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'João da Silva',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor insira seu nome';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(300),
              child: Text("Email"),
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'name@example.com',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor insira seu Email';
                } else if (!EmailValidator.validate(value, true)) {
                  return "Digite um Email válido";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(300),
              child: Text("Senha"),
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: '**********',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Digite uma senha";
                } else if (passwordController.text.length < 8) {
                  return "A senha tem que conter pelo menos 8 caracteres";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(
                  () async {
                    isSwitched = value;
                    if (isSwitched == true) {
                      await Geolocator.requestPermission();
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
