import 'dart:convert';
import 'package:sanity/apis/apis.dart';
import 'package:http/http.dart' as http;

class DasRepo {
  final APIs api = APIs();
  final client = http.Client();

  Future<Map> getDass() async {
    final http.Response response =
        await client.get(Uri.parse(api.getDass), headers: {
      "Content-type": 'application/json',
      "Accept": "application/json",
      "Access-Control-Allow_origin": "*"
    });
    final dass = json.decode(response.body);
    return dass;
  }
}
