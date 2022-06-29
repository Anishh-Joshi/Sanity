import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthRepository {
  final String Url = "http://10.0.2.2:8000/api/user/login/";

  Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('token');
    if (value != null) {
      return true;
    }
    return false;
  }

  Future<void> persistToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<Map> login(String email, password) async {
    final client = http.Client();
    final http.Response response = await client.post(Uri.parse(Url),
        body: jsonEncode({"email": email, "password": password}),
        headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Aloow_origin": "*"
        });
    final loginResponse = json.decode(response.body);
    return loginResponse;
  }
}
