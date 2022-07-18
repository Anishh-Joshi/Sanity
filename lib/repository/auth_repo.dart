import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthRepository {
  final String loginUrl = "http://10.0.2.2:8000/api/user/login/";
  final String signInUrl = "http://10.0.2.2:8000/api/user/register/";
  final String user = "http://10.0.2.2:8000/api/user/profile/";
  final String userProfile = "http://10.0.2.2:8000/api/user/profile/";

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

  Future<void> persistAppInformation() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("appInfoSeen", true);
  }

  Future<bool> hasAppInformation() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool('appInfoSeen');
    if (value != null && value) {
      return true;
    }
    return false;
  }

  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<Map> login(String email, password) async {
    final client = http.Client();
    final http.Response response = await client.post(Uri.parse(loginUrl),
        body: jsonEncode({"email": email, "password": password}),
        headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });
    final loginResponse = json.decode(response.body);
    return loginResponse;
  }

  Future<Map> signIn(String email, password, confirm_password) async {
    final client = http.Client();
    final http.Response response = await client.post(Uri.parse(signInUrl),
        body: jsonEncode({
          "email": email,
          "password": password,
          "confirm_password": confirm_password
        }),
        headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });
    final signInResponse = json.decode(response.body);
    return signInResponse;
  }

  Future<Map> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final client = http.Client();
    final String? token = prefs.getString('token');
    if (token != null) {
      final http.Response response =
          await client.get(Uri.parse(user), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      Map signInResponse = json.decode(response.body);
      return signInResponse;
    } else {
      return {};
    }
  }

  Future<Map> registeredProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final client = http.Client();
    final String? token = prefs.getString('token');
    if (token != null) {
      final http.Response response =
          await client.get(Uri.parse(user), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      Map signInResponse = json.decode(response.body);
      return signInResponse;
    } else {
      return {};
    }
  }
}
