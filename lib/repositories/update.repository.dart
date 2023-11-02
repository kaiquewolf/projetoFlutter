// ignore_for_file: unnecessary_string_interpolations, avoid_print

import 'dart:convert';

import 'package:projeto_flutter_mylink/view-models/updatemodel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateRepository {
  Future<bool> update(UpdateViewModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final token = sharedPreferences.getString('token');

    var url = Uri.parse('https://mockapi.hiperlink.pro/api/update');
    print(token);

    var response = await http.post(
      url,
      headers: {
        'Authorization':
            'Bearer 3|laravel_sanctum_h9Drpzy5JajnO8R5OgStDHGj3hUAIWd8bcq0PkH3c20d1adf',
        'Postman-Token': '$token'
      },
      body: jsonEncode(
        {
          'name': model.name,
          'email': model.email,
          'password': model.password,
          'authorize_location': model.authorizelocation
        },
      ),
    );

    print('${response.body}');

    if (response.statusCode == 200) {
      print('Atualizado com sucesso!');
      return true;
    } else {
      return false;
    }
  }
}
