import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/model/appointment_model.dart';
import 'package:sanity/repository/appointment_repository/appointment_repo.dart';
part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepository repo;
  AppointmentBloc({required this.repo}) : super(AppointmentLoaded()) {
    on<RequestAppointment>(_requestAppointment);
    on<RetrieveAppointmentDoctor>(_retrieveAppointment);
     on<UpdateAppointmentDoctor>(_updateAppointment);
  }

  void _requestAppointment(
      RequestAppointment event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoadng());
    try {

      final Map response = await repo.requestAppointment(event.userId,
          event.doctorId, event.previousMedicine, event.emergencyContact);
      if (response['status'] == 'success') {
        emit(AppointmentRequested());
        emit(AppointmentLoaded());

      } else {
        emit(const AppointmentError(err: "Something went wrong"));
      }
      
    } catch (e) {
      emit(AppointmentError(err: e.toString()));
    }
  }

    void _updateAppointment(
      UpdateAppointmentDoctor event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoadng());
    try {
      final Map response = await repo.updateAppointment(appointmentId: event.appointmentId,time: event.time);
      if (response['status'] == 'success') {
        emit(AppointmentLoaded());
      } else {
        emit(AppointmentError(err: response['status']));
      }
      emit(AppointmentLoaded());
    } catch (e) {
      emit(AppointmentError(err: e.toString()));
    }
  }

  void _retrieveAppointment(
      RetrieveAppointmentDoctor event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoadng());
    try {
      print("IS TRIGGERED");
      final Map response =
          await repo.retrieveAppointments(userId: event.doctorId,cat: 'doc');
      if (response['status'] == 'success') {
        emit(AppointmentRetrieved(appointmentList: response['appointment_data']));
      } else {
        emit(const AppointmentError(err: "Something went wrong"));
      }
    } catch (e) {
      emit(AppointmentError(err: e.toString()));
    }
  }
}
