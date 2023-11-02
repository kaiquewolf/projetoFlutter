// ignore_for_file: unnecessary_string_interpolations, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_flutter_mylink/view-models/cadastremodel.dart';

class CadastreRepository {
  Future<bool> register(CadastreViewModel model) async {
    var url = Uri.parse('https://mockapi.hiperlink.pro/api/register');

    var response = await http.post(
      url,
      body: {
        'name': '${model.name}',
        'email': '${model.email}',
        'password': '${model.password}',
        'authorize_location': "${model.authorizelocation}"
      },
    );

    print('${response.body}');

    if (response.statusCode == 200) {
      print('Cadastrado com sucesso!');
      return true;
    } else {
      print(
        jsonDecode('${response.body}'),
      );
      return false;
    }
  }
}
