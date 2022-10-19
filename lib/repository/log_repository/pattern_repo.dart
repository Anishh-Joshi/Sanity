import 'package:http/http.dart' as http;
import 'package:sanity/apis/apis.dart';
import 'dart:convert';

class PatternRepo {
  final APIs api = APIs();
  final client = http.Client();
  Future<Map> setPattern(String log, int userId) async {
    final http.Response response = await client.post(
        Uri.parse(api.setPattern),
        body: jsonEncode({"by_user": userId, "text": log}),
        headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });

    final patternResponse = json.decode(response.body);

    return patternResponse;
  }

}
