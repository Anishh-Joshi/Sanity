import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LogRepository {
  final String url = "http://10.0.2.2:8000/api/assistant/set/dailylog/";

  Future<Map> sendLog(String log, int userId) async {
    final client = http.Client();

    final http.Response response = await client.post(Uri.parse(url),
        body: jsonEncode({"user": userId, "log": log}),
        headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });
    final logResponse = json.decode(response.body);
    return logResponse;
  }


  Future<Map> retrieveLog(int userId) async {
    final client = http.Client();

    final http.Response response = await client.get(Uri.parse("http://10.0.2.2:8000/api/assistant/get/dailylog/?id=1"));

    final Map logResponse = json.decode(response.body);
    return logResponse;
  }

 
}
