import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:geolocator/geolocator.dart';

class CadastrePage extends StatefulWidget {
  const CadastrePage({super.key});

  @override
  State<CadastrePage> createState() => _CadastrePageState();
}

class _CadastrePageState extends State<CadastrePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f0f0),
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: const Column(
            children: <Widget>[
              CadastrePageForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class CadastrePageForm extends StatefulWidget {
  const CadastrePageForm({super.key});

  @override
  State<CadastrePageForm> createState() => _CadastrePageFormState();
}

class _CadastrePageFormState extends State<CadastrePageForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 50,
        bottom: 10,
        left: 20,
        right: 30,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 300, bottom: 10),
              child: Text(
                "Nome",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
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
              padding: EdgeInsets.only(right: 300, bottom: 10),
              child: Text(
                "Email",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
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
              padding: EdgeInsets.only(right: 300, bottom: 10),
              child: Text(
                "Senha",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
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
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Switch(
                    value: isSwitched,
                    onChanged: (bool value) {
                      setState(
                        () {
                          isSwitched = value;
                          if (isSwitched == true) {
                            // Geolocator.requestPermission();
                          }
                        },
                      );
                    },
                  ),
                ),
                const Text(
                  "Permitir o acesso da minha \n localização durante o uso do \n aplicativo.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                )
              ],
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  print("Sucesso");
                  emailController.clear();
                  passwordController.clear();
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xff142949),
                ),
                child: const Center(
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
