import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f0f0),
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Image.asset(
                'images/Logo.png',
              ),
              // ignore: prefer_const_constructors
              MyFormCustom(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyFormCustom extends StatefulWidget {
  const MyFormCustom({super.key});

  @override
  MyFormCustomState createState() {
    return MyFormCustomState();
  }
}

class MyFormCustomState extends State<MyFormCustom> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passToggle = true;

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
              padding: EdgeInsets.only(right: 300),
              child: Text(
                "Email",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(),
            const SizedBox(
              height: 10,
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
                  return 'Por favor insira seu email';
                } else if (!EmailValidator.validate(value, true)) {
                  return "Digite um Email válido";
                }
              },
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(right: 300.0),
              child: Text(
                "Senha",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              obscureText: passToggle,
              decoration: InputDecoration(
                labelText: "************",
                border: const OutlineInputBorder(),
                suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        passToggle = !passToggle;
                      });
                    },
                    child: Icon(
                        passToggle ? Icons.visibility : Icons.visibility_off)),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Digite uma senha";
                } else if (passwordController.text.length < 8) {
                  return "A senha tem que conter pelo menos 8 caracteres";
                }
              },
            ),
            const SizedBox(height: 20),
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
                    "Acessar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2a8aa6)),
                child: const Text("Criar conta"),
                onPressed: () {
                  return;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
