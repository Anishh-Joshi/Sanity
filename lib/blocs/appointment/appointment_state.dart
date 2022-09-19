part of 'appointment_bloc.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

class AppointmentLoadng extends AppointmentState {}

class AppointmentLoaded extends AppointmentState {}

class AppointmentRetrieved extends AppointmentState {
  final List appointmentList;

  const AppointmentRetrieved({required this.appointmentList});
  @override
  List<Object> get props => [appointmentList];
}

class AppointmentRequested extends AppointmentState {
  final AppointmentModel appointmentModel;

  const AppointmentRequested({required this.appointmentModel});
  @override
  List<Object> get props => [appointmentModel];
}

class AppointmentUpdated extends AppointmentState {}

class AppointmentError extends AppointmentState {
  final String err;

  const AppointmentError({required this.err});
  @override
  List<Object> get props => [err];
}
