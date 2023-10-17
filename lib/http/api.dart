import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_flutter_mylink/http/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi <User>{
  static Future<bool> login(String user, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var url = Uri.parse('https://mockapi.hiperlink.pro/api/login');

    var response = await http.post(
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
