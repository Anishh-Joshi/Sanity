import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/repository/log_repository/log_repo.dart';
import 'package:sanity/repository/log_repository/pattern_repo.dart';
part 'log_bloc_event.dart';
part 'log_bloc_state.dart';

class LogBlocBloc extends Bloc<LogBlocEvent, LogBlocState> {
  final LogRepository repo;
  final PatternRepo patternRepo = PatternRepo();

  LogBlocBloc({required this.repo}) : super(LogBlocLoading()) {
    on<LogSendButtonPressed>(_sendLog);
    on<RetrieveLog>(_retrieveLog);
    on<RetrievePattern>(_retrievePattern);
  }

  void _sendLog(LogSendButtonPressed event, Emitter<LogBlocState> emit) async {
    emit(LogSending());
    try {
      await repo.sendLog(event.log, event.userId);
      final Map receivedMap = await repo.retrieveLog(event.userId);
      emit(LogRetrieved(log: receivedMap['candidates']));
      patternRepo.setPattern(event.log, event.userId);
    } catch (e) {}
  }

  void _retrieveLog(RetrieveLog event, Emitter<LogBlocState> emit) async {
    emit(LogBlocLoading());
    final Map receivedMap = await repo.retrieveLog(event.id);
    emit(LogRetrieved(log: receivedMap['candidates']));
  }

  void _retrievePattern(
      RetrievePattern event, Emitter<LogBlocState> emit) async {
    emit(LogBlocLoading());
    print(event.userId);
    final Map receivedMap = await repo.getMeanPattern(event.userId);

    print(receivedMap);

    if (state is LogRetrieved) {
      final state = this.state as LogRetrieved;
      emit(LogRetrieved(
          log: state.log,
          avgPattern: receivedMap['avg_pattern'],
          selfPattern: receivedMap['pattern']));
    } else {
      final Map receivedMapLogs = await repo.retrieveLog(event.userId);
      emit(LogRetrieved(
          log: receivedMapLogs['candidates'],
          avgPattern: receivedMap['avg_pattern'],
          selfPattern: receivedMap['pattern']));
    }
  }
}
