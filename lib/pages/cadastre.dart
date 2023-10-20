import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:location/location.dart';
import 'package:projeto_flutter_mylink/http/api.dart';
import 'package:projeto_flutter_mylink/pages/welcome.dart';

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
          child: Container(
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
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isSwitched = false;
  Location location = Location();

  // void locationCheckPermission() async {
  //   final permission = await Geolocator.checkPermission;
  //   _determinePosition();
  //   if (isSwitched == true) {
  //     Geolocator.requestPermission();
  //   } else if (permission == LocationPermission.denied) {
  //     isSwitched = false;

  //     // LocationPermission.denied;
  //   }
  // }

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
                }
                return null;
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
                    padding: EdgeInsets.only(top: 20.0, right: 20),
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
                          location.requestPermission();
                        } else {}
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
            InkWell(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (_formKey.currentState!.validate()) {
                  _onClickCadastre(context);
                  currentFocus.unfocus();
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

  _onClickCadastre(BuildContext context) async {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    print(
        "login: $name, Email: $email,  Senha: $password, isSwitched: $isSwitched");

    var response = await RegisterUserApi.register(
      name,
      email,
      password,
      isSwitched,
    );
    if (response == true) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomePage(),
        ),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBarSucceess);
    } else {
      passwordController.clear();
      print("${response}");
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBarError);
    }
  }

  final snackBarError = const SnackBar(
    content: Text(
      'Não foi possível realizar o  cadastro!',
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.redAccent,
  );

  final snackBarSucceess = const SnackBar(
    content: Text(
      'Cadastrado com sucesso!',
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.greenAccent,
  );
  final MaterialStateProperty<Color?> overlayColor =
      MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      // Material color when switch is selected.
      if (states.contains(MaterialState.selected)) {
        return Colors.grey.shade400;
      }
      // Material color when switch is disabled.
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey.shade400;
      }
      // Otherwise return null to set default material color
      // for remaining states such as when the switch is
      // hovered, or focused.
      return null;
    },
  );

  final MaterialStateProperty<Color?> trackColor =
      MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      // Track color when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return Colors.black;
      }
      // Otherwise return null to set default track color
      // for remaining states such as when the switch is
      // hovered, focused, or disabled.
      return null;
    },
  );
}
