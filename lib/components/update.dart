import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:location/location.dart';
import 'package:projeto_flutter_mylink/http/api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projeto_flutter_mylink/pages/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateComponent extends StatefulWidget {
  const UpdateComponent({super.key});

  @override
  State<UpdateComponent> createState() => _UpdateComponent();
}

class _UpdateComponent extends State<UpdateComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f0f0),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: const Column(
            children: <Widget>[
              UpdatePageForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class UpdatePageForm extends StatefulWidget {
  const UpdatePageForm({super.key});

  @override
  State<UpdatePageForm> createState() => _UpdatePageFormState();
}

class _UpdatePageFormState extends State<UpdatePageForm> {
  final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isSwitched = false;
  Location location = Location();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
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
                    Padding(
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
                      if (!currentFocus.hasPrimaryFocus) {
                        _onClickUpdate(context);
                        currentFocus.unfocus();
                      }
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
                        "Atualizar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onClickUpdate(BuildContext context) async {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    print(
        "login: $name, Email: $email,  Senha: $password, isSwitched: $isSwitched");

    var response =
        await UpdateUserApi.update(name, email, password, isSwitched);
    if (response == true) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        ),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBarSucceess);
    } else {
      passwordController.clear();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBarError);
    }
  }

  final snackBarError = const SnackBar(
    content: Text(
      'Não foi possível atualizar o  cadastro!',
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.redAccent,
  );

  final snackBarSucceess = const SnackBar(
    content: Text(
      'Atualizado com sucesso!',
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

Future<bool> remove() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.clear();
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
