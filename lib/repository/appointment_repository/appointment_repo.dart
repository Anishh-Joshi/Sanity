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

  Future<Map> updateAppointment(
      {required int appointmentId, required DateTime time}) async {
    final client = http.Client();
    final http.Response response = await http.put(
      Uri.parse(api.updateAppointment(appointmentId)),
      body: jsonEncode({"at_time": time.toIso8601String(), 'pending': false}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final appointmentResponse = json.decode(response.body);
    return appointmentResponse;
  }

  Future<Map> retrieveAppointments(
      {required int userId, required String cat}) async {
    final client = http.Client();
    final http.Response response = await client
        .get(Uri.parse(api.retrieveAppointment(id: userId, key: 1, cat: cat)));
    final Map logResponse = json.decode(response.body);
    return logResponse;
  }

  Future<Map> retrieveAppointmentsNotification(
      {required int userId, required String cat}) async {
    final client = http.Client();
    final http.Response response = await client
        .get(Uri.parse(api.retrieveAppointment(id: userId, key: 2, cat: cat)));
    final Map logResponse = json.decode(response.body);
    return logResponse;
  }

  Future<Map> sendReport(int appointmentId, List medicines, int doctorId,
      int patientId, String diaognosis) async {
    final client = http.Client();
    final http.Response response =
        await client.post(Uri.parse(api.sendReport),
            body: jsonEncode({
              'appointment': appointmentId,
              'by_doctor': doctorId,
              'for_user': patientId,
              'diagnosis': diaognosis,
              'medicines': medicines,
            }),
            headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });
    final reportResponse = json.decode(response.body);
    return reportResponse;
  }


  Future<Map> getReport( int id,String cat) async {
    final client = http.Client();
    final http.Response response =
        await client.get(Uri.parse(api.sendReport+"?id=$id&cat=$cat"),
            headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });
    final reportResponse = json.decode(response.body);
    return reportResponse;
  }
}
