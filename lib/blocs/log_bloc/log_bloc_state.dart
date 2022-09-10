part of 'log_bloc_bloc.dart';

abstract class LogBlocState extends Equatable {
  const LogBlocState();
  
  @override
  List<Object> get props => [];
}

class LogRetrieved extends LogBlocState {
  final List log;

  const LogRetrieved({required this.log});
  @override
  List<Object> get props => [log];
}
class LogBlocLoading extends LogBlocState {}
class LogSending extends LogBlocState{}
class LogSent extends LogBlocState{}
