import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi<User> {
  static Future<bool> login(String user, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var url = Uri.parse('https://mockapi.hiperlink.pro/api/login');

    final response = await http.post(
      url,
      body: {'email': user, 'password': password},
    );

    print('${response.body}');

    if (response.statusCode == 200) {
      await sharedPreferences.setString(
          'token', "token${jsonDecode(response.body)['data']['token']}");

      print(sharedPreferences.getString('token'));
      return true;
    } else {
      print(
        jsonDecode(response.body),
      );
      return false;
    }
  }
}

class UpdateUserApi<User> {
  static Future<bool> update(
      String name, String user, String password, bool authorizelocation) async {
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
          'name': name,
          'email': user,
          'password': password,
          'authorize_location': authorizelocation
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

class RegisterUserApi<User> {
  static Future<bool> register(
      String name, String user, String password, bool authorizelocation) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final token = sharedPreferences.getString('token');

    var url = Uri.parse('https://mockapi.hiperlink.pro/api/register');

    print(token);

    var response = await http.post(
      url,
      body: {
        'name': '${name}',
        'email': '${user}',
        'password': '${password}',
        'authorize_location': "${authorizelocation}"
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
