import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/repository/threads_repository/threds_repo.dart';

import '../../repository/log_repository/pattern_repo.dart';
part 'threads_event.dart';
part 'threads_state.dart';

class ThreadsBloc extends Bloc<ThreadsEvent, ThreadsState> {
  final ThreadsRepo _threadRepo;
  ThreadsBloc({required ThreadsRepo threadRepo})
      : _threadRepo = threadRepo,
        super(ThreadsLoading()) {
    on<FetchAllThreads>(_onFetchAllThreads);
    on<UpVote>(_onUpVote);
    on<RemoveUpVote>(_onRmoveUpvote);
    on<AddThread>(_onAddThread);
    on<DeleteThread>(_onDeleteThread);
  }

  void _onFetchAllThreads(
    FetchAllThreads event,
    Emitter<ThreadsState> emit,
  ) async {
    emit(ThreadsLoading());
    try {
      final Map response = await _threadRepo.getThreads();
      emit(ThreadsLoaded(
          threads: response['threads'],
          owners: response['user_info'],
          upVotes: response['up_votes'],
          comments: response['comments']));
    } catch (e) {
      emit(ThreadsError(err: e.toString()));
    }
  }

  void _onUpVote(
    UpVote event,
    Emitter<ThreadsState> emit,
  ) async {
    try {
      await _threadRepo.upVote(threadId: event.threadId, userId: event.userId);
    } catch (e) {}
  }

  void _onRmoveUpvote(
    RemoveUpVote event,
    Emitter<ThreadsState> emit,
  ) async {
    try {
      await _threadRepo.downVote(
          threadId: event.threadId, userId: event.userId);
    } catch (e) {}
  }

  void _onAddThread(
    AddThread event,
    Emitter<ThreadsState> emit,
  ) async {
    try {
      await _threadRepo.addThread(
          userId: event.userId, title: event.title, content: event.content);
      final Map response = await _threadRepo.getThreads();
      emit(ThreadsLoaded(
          threads: response['threads'],
          owners: response['user_info'],
          upVotes: response['up_votes'],
          comments: response['comments']));

      final PatternRepo patternRepo = PatternRepo();
      patternRepo.setPattern(event.content, event.userId);
    } catch (e) {
      print('object');
    }
  }

  void _onDeleteThread(
    DeleteThread event,
    Emitter<ThreadsState> emit,
  ) async {
    if (this.state is ThreadsLoaded) {
      final state = this.state as ThreadsLoaded;

      try {
        emit(ThreadsLoading());
        await _threadRepo.deleteThread(threadId: event.threadId);
        final Map response = await _threadRepo.getThreads();
        emit(ThreadsLoaded(
            threads: response['threads'],
            owners: response['user_info'],
            upVotes: response['up_votes'],
            comments: response['comments']));
      } catch (e) {
        emit(ThreadsError(err: e.toString()));
      }
    }
  }
}
