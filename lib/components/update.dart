import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projeto_flutter_mylink/components/switch.dart';

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
        child: Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: const Column(
              children: <Widget>[
                UpdatePageForm(),
              ],
            ),
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
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isSwitched = false;

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
                    } else if (passwordController.text.length < 8) {
                      return "A senha tem que conter pelo menos 8 caracteres";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, right: 20),
                      child: SwitchLocation(),
                    ),
                    Text(
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
}
