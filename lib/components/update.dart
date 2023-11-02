// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projeto_flutter_mylink/controllers/update.controller.dart';
import 'package:projeto_flutter_mylink/theme/switchtheme.dart';
import 'package:projeto_flutter_mylink/view-models/updatemodel.dart';

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
        child: SizedBox(
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
  final _controller = UpdateController();

  var model = UpdateViewModel();
  bool isSwitched = false;
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
                  onSaved: (value) => value,
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
                  onSaved: (value) => value,
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
                  onSaved: (value) => value,
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  children: [
                    Padding(
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
                              _formKey.currentState?.save();
                              currentFocus.unfocus();
                              setState(() {
                                model.buzy = true;
                              });
                              _controller.update(model, context);
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
}
