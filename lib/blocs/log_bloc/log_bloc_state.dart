part of 'log_bloc_bloc.dart';

abstract class LogBlocState extends Equatable {
  const LogBlocState();
  
  @override
  List<Object> get props => [];
}

class LogBlocInitial extends LogBlocState {}
class LogSending extends LogBlocState{}
class LogSent extends LogBlocState{}
