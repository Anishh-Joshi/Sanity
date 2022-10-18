import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/apis/apis.dart';
import 'package:sanity/model/appointment_model.dart';
import 'package:sanity/model/user_info_model.dart';
import 'package:sanity/repository/appointment_repository/appointment_repo.dart';
import 'package:sanity/repository/auth_repo.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final AppointmentRepository repo = AppointmentRepository();
  ReportBloc() : super(ReportLoading()) {
    on<SendReport>(_sendReport);
    on<FetchReports>(_fetchReport);
  }

  void _sendReport(SendReport event, Emitter<ReportState> emit) async {
    List meds = [];
    event.reportData.forEach((key, value) {
      meds.add(value);
    });

    try {
      emit(ReportLoading());
      final Map response = await repo.sendReport(
          event.appointment.appointmentId!,
          meds,
          event.appointment.doctor.userId!,
          event.appointment.patient.userId!,
          event.diaognosis);
      if (response.containsKey('appointment') &&
          response['appointment'][0] == "This field must be unique.") {
        emit(const ReportError(
            msg: "Report for this appointment is already exists."));
      } else {
        emit(const ReportLoaded());
      }
    } catch (e) {
      emit(ReportError(msg: e.toString()));
    }
  }

  void _fetchReport(FetchReports event, Emitter<ReportState> emit) async {
    try {
      emit(ReportLoading());
      final Map response = await repo.getReport(
        event.user.userId!,
        event.user.isDoctor! ? "doc" : "pat",
      );
      emit(ReportLoaded(reports: response['report']));
    } catch (e) {
      emit(ReportError(msg: e.toString()));
    }
  }
}
