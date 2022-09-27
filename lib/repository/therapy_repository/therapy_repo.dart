import 'package:http/http.dart' as http;
import 'package:sanity/apis/apis.dart';
import 'dart:convert';

class TherapyRepository {
  final APIs api = APIs();

  Future<Map> getAllTherapy() async {
    final client = http.Client();
    final http.Response response =
        await client.get(Uri.parse(api.getAllTherapy()));
    final Map therapyResponse = json.decode(response.body);
    return therapyResponse;
  }

  Future<Map> getTherapyDetails({required int id}) async {
    final client = http.Client();
    final http.Response response =
        await client.get(Uri.parse(api.getTherapyDetails(id: id)));
    final Map therapyDetailsResponse = json.decode(response.body);
    return therapyDetailsResponse;
  }

  Future<Map> addTherapy(
    int docId,
    String contents,
    String category,
    String title,
  ) async {
    final client = http.Client();

    final http.Response response = await client.post(Uri.parse(api.addTherapy),
        body: jsonEncode({
          "added_by_doctor": docId,
          "category": category,
          "title": title,
        }),
        headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });
    final logResponse = json.decode(response.body);

    final http.Response formResponse =
        await client.post(Uri.parse(api.addTherapyDetails),
            body: jsonEncode({
              "contents": contents,
              "doctor_profile": logResponse['data']['added_by_doctor'],
              "fk_therapy": logResponse['data']['therapy_id'],
            }),
            headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });
    final finalResponse = json.decode(formResponse.body);
    return finalResponse;
  }
}
