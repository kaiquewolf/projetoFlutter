// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_flutter_mylink/view-models/loginmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  Future<bool> login(LoginViewModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var url = Uri.parse('https://mockapi.hiperlink.pro/api/login');

    var response = await http.post(
      url,
      body: {'email': '${model.email}', 'password': '${model.password}'},
    );
    print('${model.email}');
    // ignore: unnecessary_string_interpolations
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
