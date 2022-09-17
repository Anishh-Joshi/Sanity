import 'package:http/http.dart' as http;
import 'package:sanity/apis/apis.dart';
import 'dart:convert';

class LogRepository {
  final APIs api = APIs();

  Future<Map> sendLog(String log, int userId) async {
    final client = http.Client();

    final http.Response response = await client.post(Uri.parse(api.sendDailyLog),
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
    final http.Response response = await client.get(Uri.parse(api.retrieveLog(id: userId)));
    final Map logResponse = json.decode(response.body);
    return logResponse;
  }

}
