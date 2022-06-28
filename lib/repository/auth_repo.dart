import 'package:http/http.dart' as http;
import 'dart:convert';

class Authrepository {
  static login(String email, String password) async {
    var res = await http.post(
      Uri.parse(
        "http://127.0.0.1:8000/api/user/login/",
      ),
      headers: {},
      body: {"email": email, "password": password},
    );
    final data = json.decode(res.body);
    return data;
  }
}
