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
        await client.get(Uri.parse(api.getTherapyDetails(id:id )));
    final Map therapyDetailsResponse = json.decode(response.body);
    return therapyDetailsResponse;
  }
}
