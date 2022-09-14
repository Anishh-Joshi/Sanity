import 'package:http/http.dart' as http;
import 'package:sanity/apis/apis.dart';
import 'dart:convert';

class AppointmentRepository {
  final APIs api = APIs();

  Future<Map> requestAppointment(int userId, int doctorId,
      String previousMedicine, int emergencyContact) async {
    final client = http.Client();

    final http.Response response =
        await client.post(Uri.parse(api.requestAppointment()),
            body: jsonEncode({
              "user": userId,
              "appointed_to": doctorId,
              "previous_medication": previousMedicine,
              "emergency_contact": emergencyContact
            }),
            headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });
    final appointmentResponse = json.decode(response.body);
    return appointmentResponse;
  }

  Future<Map> retrieveAppointments({required int userId}) async {
    final client = http.Client();
    final http.Response response =
        await client.get(Uri.parse(api.retrieveAppointment(id: userId)));
    final Map logResponse = json.decode(response.body);
    return logResponse;
  }
}
