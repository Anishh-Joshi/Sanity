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

  Future<Map> getAnswers({required int profileId}) async {
    final http.Response response =
        await client.get(Uri.parse(api.getAnswers(id: profileId)), headers: {
      "Content-type": 'application/json',
      "Accept": "application/json",
      "Access-Control-Allow_origin": "*"
    });
    final answer = json.decode(response.body);
    return answer;
  }

  Future<Map> setAnswer(int profileId, List sheet) async {
    final client = http.Client();
    final http.Response response = await client.post(Uri.parse(api.setAnswer),
        body: jsonEncode({
          "user": profileId,
          "response": sheet,
          "category":1
        }),
        headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });
    final answers = json.decode(response.body);
    return answers;
  
  }
}
