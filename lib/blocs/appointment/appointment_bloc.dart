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
  }

  void _requestAppointment(
      RequestAppointment event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoadng());
    try {
      final Map response = await repo.requestAppointment(event.userId,
          event.doctorId, event.previousMedicine, event.emergencyContact);
      if (response['status'] == 'success') {
        final AppointmentModel appointModel =
            AppointmentModel.fromJSON(response['appointment_data']);
        emit(AppointmentRequested(appointmentModel: appointModel));
      } else {
        emit(const AppointmentError(err: "Something went wrong"));
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
      final Map response =
          await repo.retrieveAppointments(userId: event.doctorId);
          print(response);
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
