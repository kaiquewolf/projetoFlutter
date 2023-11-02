import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projeto_flutter_mylink/controllers/cadastre.controller.dart';
import 'package:projeto_flutter_mylink/theme/switchtheme.dart';
import 'package:projeto_flutter_mylink/view-models/cadastremodel.dart';

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
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Column(
              children: <Widget>[
                CadastrePageForm(),
              ],
            ),
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
  final _controller = CadastreController();

  var model = CadastreViewModel();
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
              onSaved: (value) {
                model.name = value;
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
              onSaved: (value) {
                model.email = value;
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
              decoration: const InputDecoration(
                labelText: '**********',
                border: OutlineInputBorder(),
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
            const SizedBox(
              height: 20,
            ),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 20),
                    child: Switch(
                      overlayColor: overlayColor,
                      trackColor: trackColor,
                      thumbColor:
                          const MaterialStatePropertyAll<Color>(Colors.white),
                      value: isSwitched,
                      onChanged: (bool value) {
                        setState(() {
                          isSwitched = value;
                        });
                        if (isSwitched == true) {
                          Geolocator.requestPermission();
                        } else {}
                        model.authorizelocation = isSwitched;
                      },
                    ),
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
                        _formKey.currentState?.save();
                        currentFocus.unfocus();
                        setState(() {
                          model.buzy = true;
                        });
                        _controller.register(model, context);
                      }
                      setState(() {
                        model.buzy = false;
                      });
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
