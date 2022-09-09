part of 'log_bloc_bloc.dart';

abstract class LogBlocEvent extends Equatable {
  const LogBlocEvent();

  @override
  List<Object> get props => [];
}

class LogLoading extends LogBlocEvent {}

class CheckLogToday extends LogBlocEvent {
  
}

class LogSendButtonPressed extends LogBlocEvent{
  final String log;
  final int userId;

  const LogSendButtonPressed({required this.log, required this.userId});
  @override
  List<Object> get props => [log, userId];

}
