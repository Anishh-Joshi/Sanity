class AppointmentModel {
  final int? appointmentId;
  final int? patientName;
  final int? doctorName;
  final DateTime? createdAt;
  final DateTime? atTime;
  final int? emergencyContact;
  final String? previousMedications;
  final bool? pending;

  AppointmentModel(
      {required this.pending,
      this.appointmentId,
      required this.patientName,
      required this.doctorName,
      required this.createdAt,
      this.atTime,
      required this.emergencyContact,
      this.previousMedications});

  factory AppointmentModel.fromJSON(Map response) {
    return AppointmentModel(
      appointmentId: response['id'],
      patientName: response['user_id'],
      doctorName: response['appointed_to_id'],
      createdAt: DateTime.parse(response['created_at']),
      emergencyContact: response['emergency_contact'],
      previousMedications: response['previous_medication'],
      pending: response['pending'],
    );
  }
}
