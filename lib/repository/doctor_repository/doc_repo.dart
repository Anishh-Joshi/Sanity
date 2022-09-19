import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sanity/apis/apis.dart';

class DoctorRepository{
  final APIs api = APIs();

  Future<Map> retrieveLog() async {
    final client = http.Client();
    final http.Response response = await client.get(Uri.parse(api.getDoctorList));
    final Map logResponse = json.decode(response.body);
    return logResponse;
  }
}