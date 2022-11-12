import 'package:http/http.dart' as http;
import 'package:sanity/apis/apis.dart';
import 'dart:convert';

class LogRepository {
  final APIs api = APIs();
  final client = http.Client();
  Future<Map> sendLog(String log, int userId) async {
    final http.Response response = await client.post(
        Uri.parse(api.sendDailyLog),
        body: jsonEncode({"user": userId, "log": log}),
        headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });

    final logResponse = json.decode(response.body);

    return logResponse;
  }

  Future<Map> retrieveLog(int? userId) async {
    final http.Response response =
        await client.get(Uri.parse(api.retrieveLog(id: userId!)));
    final Map logResponse = json.decode(response.body);
    return logResponse;
  }


  Future<Map> getMeanPattern(int id)async{
     final client = http.Client();
     print("itthe");
    final http.Response response =
        await client.get(Uri.parse(api.getPattern(id)), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Access-Control-Allow_origin": "*"
    });
    Map pattern = json.decode(response.body);
       print("itthe3");
    return pattern;
  }

}
