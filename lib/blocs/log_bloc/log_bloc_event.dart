part of 'log_bloc_bloc.dart';

abstract class LogBlocEvent extends Equatable {
  const LogBlocEvent();

  @override
  List<Object> get props => [];
}

class RetrieveLog extends LogBlocEvent {
  final int id;
  const RetrieveLog({required this.id});
  @override
  List<Object> get props => [id];
}

class LogSendButtonPressed extends LogBlocEvent {
  final String log;
  final int userId;
  const LogSendButtonPressed({required this.log, required this.userId});
  @override
  List<Object> get props => [log, userId];
}

class RetrievePattern extends LogBlocEvent {
  final int userId;
  RetrievePattern({required this.userId});
  @override
  List<Object> get props => [userId];
}
