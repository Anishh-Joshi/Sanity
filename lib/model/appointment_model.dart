import 'package:sanity/model/user_info_model.dart';

class AppointmentModel {
  final int? appointmentId;
  final DateTime? createdAt;
  final DateTime? atTime;
  final int? emergencyContact;
  final String? previousMedications;
  final bool? pending;
  final UserInfoModel patient;
  final UserInfoModel doctor;
  
  final DateTime dummyDate = DateTime.now();

  AppointmentModel(
      {required this.pending,
      this.appointmentId,
      required this.doctor,
      required this.patient,
      required this.createdAt,
      this.atTime,
      required this.emergencyContact,
      this.previousMedications});
  factory AppointmentModel.fromJSON(Map response) {
    return AppointmentModel(
      doctor: UserInfoModel.fromJson(response['appointed_to']),
      patient: UserInfoModel.fromJson(response['user']),
      appointmentId: response['id'],
      atTime:response['at_time'] ==null?null:DateTime.parse(response['at_time']),
      createdAt: DateTime.parse(response['created_at']),
      emergencyContact: response['emergency_contact'],
      previousMedications: response['previous_medication'],
      pending: response['pending'],
    );
  }
}
