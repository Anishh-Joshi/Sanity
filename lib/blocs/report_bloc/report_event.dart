part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

class FetchReports extends ReportEvent {
  final UserInfoModel user;

  const FetchReports({required this.user});

  @override
  List<Object> get props => [user];
}

class SendReport extends ReportEvent {
  final AppointmentModel appointment;
  final Map reportData;
  final String diaognosis;

  const SendReport(
      {required this.appointment,
      required this.reportData,
      required this.diaognosis});
}
