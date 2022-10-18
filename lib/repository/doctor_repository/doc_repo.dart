import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sanity/apis/apis.dart';

class DoctorRepository {
  final APIs api = APIs();

  Future<Map> retrieveLog() async {
    final client = http.Client();
    final http.Response response =
        await client.get(Uri.parse(api.getDoctorList));
    final Map logResponse = json.decode(response.body);
    return logResponse;
  }

  final client = http.Client();
  Future<Map> getDocInfo({required int profileId}) async {
    final client = http.Client();
    final http.Response response =
        await client.get(Uri.parse(api.getDocInfo(profileId: profileId)));
    final Map info = json.decode(response.body);
    return info;
  }

  Future<Map> updateDocInfo(
      {required int profileId,
      String? major,
      String? degree,
      String? tenure,
      String? from}) async {
    final http.Response response =
        await client.post(Uri.parse(api.updateDocInfo(profileId: profileId)),
            body: jsonEncode({
              'user': profileId,
              'degree': degree,
              'major_in': major,
              'tenure': tenure,
              'education': from,
            }),
            headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });
    final info = json.decode(response.body);
    return info;
  }

  Future<Map> updateDocInfoSettings(
      {required int profileId,
      String? major,
      String? degree,
      String? tenure,
      String? from}) async {
    final http.Response response =
        await client.put(Uri.parse(api.updateDocInfo(profileId: profileId)),
            body: jsonEncode({
              'user': profileId,
              'degree': degree,
              'major_in': major,
              'tenure': tenure,
              'education': from,
            }),
            headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });
    final info = json.decode(response.body);
    return info;
  }
  //   Future<Map> setDocInfo({}) async {
  //   final client = http.Client();
  //   final http.Response response = await client.get(Uri.parse(api.updateDocInfo(profileId: profileId)));
  //   final Map logResponse = json.decode(response.body);
  //   return logResponse;
  // }
}
