part of 'appointment_bloc.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class RequestAppointment extends AppointmentEvent {
  final int userId;

  final int doctorId;

  final String previousMedicine;

  final int emergencyContact;

  const RequestAppointment(
      {
      required this.userId,
      required this.doctorId,
      required this.previousMedicine,
      required this.emergencyContact});

  @override
  List<Object> get props => [userId,doctorId,previousMedicine,emergencyContact];
}

class RetrieveAppointmentDoctor extends AppointmentEvent {
  final int doctorId;

  const RetrieveAppointmentDoctor({required this.doctorId});
  @override
  List<Object> get props => [doctorId];

}
