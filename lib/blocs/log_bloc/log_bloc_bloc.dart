import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/repository/log_repository/log_repo.dart';
import 'package:intl/intl.dart';
part 'log_bloc_event.dart';
part 'log_bloc_state.dart';

class LogBlocBloc extends Bloc<LogBlocEvent, LogBlocState> {
  final LogRepository repo;

  LogBlocBloc({required this.repo}) : super(LogBlocInitial()) {
    on<LogSendButtonPressed>(_sendLog);
    on<LogLoading>(_logLoading);
    on<CheckLogToday>(_checkLog);
  }

  void _sendLog(LogSendButtonPressed event, Emitter<LogBlocState> emit) async {
    emit(LogSending());
    try {
      await repo.sendLog(event.log, event.userId);
    } catch (e) {
      print(e.toString());
      emit(LogSent());
    }
    emit(LogSent());
  }

  void _logLoading(LogLoading event, Emitter<LogBlocState> emit) async {
    emit(LogSent());
  }

  void _checkLog(CheckLogToday event, Emitter<LogBlocState> emit) async {
    final Map receivedMap = await repo.retrieveLog(1);
    emit(LogSent());
  }

}
