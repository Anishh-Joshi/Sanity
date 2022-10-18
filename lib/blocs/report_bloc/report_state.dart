part of 'report_bloc.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportLoading extends ReportState {}

class ReportLoaded extends ReportState {
  final List? reports;

  const ReportLoaded({this.reports});
  @override
  List<Object> get props => [reports!];
}

class ReportError extends ReportState {
  final String msg;

  const ReportError({required this.msg});
  @override
  List<Object> get props => [msg];
}
