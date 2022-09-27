import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/repository/log_repository/log_repo.dart';
part 'log_bloc_event.dart';
part 'log_bloc_state.dart';

class LogBlocBloc extends Bloc<LogBlocEvent, LogBlocState> {
  final LogRepository repo;

  LogBlocBloc({required this.repo}) : super(LogBlocLoading()) {
    on<LogSendButtonPressed>(_sendLog);
    on<RetrieveLog>(_retrieveLog);
  }

  void _sendLog(LogSendButtonPressed event, Emitter<LogBlocState> emit) async {
    emit(LogSending());
    try {
      await repo.sendLog(event.log, event.userId);
    } catch (e) {
      emit(LogSent());
    }
    emit(LogSent());
  }


  void _retrieveLog(RetrieveLog event, Emitter<LogBlocState> emit) async {
    emit(LogBlocLoading());
    final Map receivedMap = await repo.retrieveLog(event.id);
    emit(LogRetrieved(log: receivedMap['candidates']));

  }

}
