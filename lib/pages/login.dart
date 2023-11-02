import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:projeto_flutter_mylink/controllers/login.controller.dart';
import 'package:projeto_flutter_mylink/pages/cadastre.dart';
import 'package:projeto_flutter_mylink/view-models/loginmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f0f0),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
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
  final _controller = LoginController();

  var model = LoginViewModel();
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
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
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
                return null;
              },
              onSaved: (value) {
                model.email = value;
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
                }
                return null;
              },
              onSaved: (value) {
                model.password = value;
              },
            ),
            const SizedBox(height: 20),
            model.buzy
                ? const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Color(0xff142949),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (_formKey.currentState!.validate()) {
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        _formKey.currentState?.save();
                        setState(() {
                          model.buzy = true;
                        });
                        _controller.login(model, context);
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
                  backgroundColor: const Color(0xff2a8aa6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                ),
                child: const Text(
                  "Criar conta",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CadastrePage()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
