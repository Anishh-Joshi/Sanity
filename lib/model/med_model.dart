import 'package:sanity/model/appointment_model.dart';
import 'package:sanity/model/user_info_model.dart';

class ReportModel {
  final AppointmentModel appointmentInformation;
  final String diaognosis;
  final List medications;
  final DateTime createdAt;

  ReportModel(
      {required this.appointmentInformation,
      required this.diaognosis,
      required this.createdAt,
      required this.medications});

  factory ReportModel.fromJSON(Map response) {
    return ReportModel(
      createdAt: DateTime.parse(response['created_at']),
        appointmentInformation:
            AppointmentModel.fromJSONForReport(response['appointment'], response['by_doctor'], response['for_user']),
        diaognosis: response['diagnosis'],
        medications: response['medicines']);
  }
}
