part of 'log_bloc_bloc.dart';

abstract class LogBlocState extends Equatable {
  const LogBlocState();
  
  @override
  List<Object> get props => [];
}

class LogRetrieved extends LogBlocState {
  final List log;
  final double? selfPattern;
  final double? avgPattern;

  const LogRetrieved({required this.log,this.avgPattern,this.selfPattern});
  @override
  List<Object> get props => [log];
}
class LogBlocLoading extends LogBlocState {}
class LogSending extends LogBlocState{}
class LogSent extends LogBlocState{}
