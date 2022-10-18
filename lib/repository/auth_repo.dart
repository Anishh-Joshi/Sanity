import 'package:http/http.dart' as http;
import 'package:sanity/apis/apis.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthRepository {
  final APIs api = APIs();
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
    final http.Response response = await client.post(Uri.parse(api.loginUrl),
        body: jsonEncode({"email": email, "password": password}),
        headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });
    final loginResponse = json.decode(response.body);
    return loginResponse;
  }

  Future<Map> changePassword(
    String email,
    password,
    confirmPassword,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final client = http.Client();
    final String? token = prefs.getString('token');
    final http.Response response = await client.post(
        Uri.parse(api.changePassword),
        body: jsonEncode({
          "email": email,
          "password": password,
          "confirm_password": confirmPassword
        }),
        headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer $token',
        });
    final loginResponse = json.decode(response.body);
    return loginResponse;
  }

  Future<Map> signIn(String email, password, confirmPassword) async {
    final client = http.Client();
    final http.Response response = await client.post(Uri.parse(api.signInUrl),
        body: jsonEncode({
          "email": email,
          "password": password,
          "confirm_password": confirmPassword
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
          await client.get(Uri.parse(api.user), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      Map signInResponse = json.decode(response.body);
      return signInResponse;
    } else {
      return {"tokenError": true};
    }
  }

  Future<Map> registeredProfileData({required int id}) async {
    final client = http.Client();

    final http.Response response =
        await client.get(Uri.parse(api.userProfile(id: id)), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Access-Control-Allow_origin": "*"
    });
    Map signInResponse = json.decode(response.body);
    return signInResponse;
  }

  Future<Map> getNumbers({required int id}) async {
    final client = http.Client();

    final http.Response response =
        await client.get(Uri.parse(api.getNumbers(id)), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Access-Control-Allow_origin": "*"
    });
    Map numberResponse = json.decode(response.body);
    return numberResponse;
  }
}
