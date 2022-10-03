import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/repository/threads_repository/threds_repo.dart';
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
    on<DoctorsInvolved>(_onDoctorsInvolved);
    on<AddThread>(_onAddThread);
    on<UpdateThread>(_onUpdateThread);
    on<DeleteThread>(_onDeleteThread);
  }

  void _onFetchAllThreads(
    FetchAllThreads event,
    Emitter<ThreadsState> emit,
  ) async {
    emit(ThreadsLoading());
    try {
      print("deleted");
      final Map response = await _threadRepo.getThreads();
      emit(ThreadsLoaded(
          threads: response['threads'],
          owners: response['user_info'],
          upVotes: response['up_votes'],
          comments: response['comments']));
                print("deleted conform");
    } catch (e) {
      print("error");
      emit(ThreadsError(err: e.toString()));
    }
  }

  void _onUpVote(
    UpVote event,
    Emitter<ThreadsState> emit,
  ) async {
    try {
      await _threadRepo.upVote(threadId: event.threadId, userId: event.userId);
    } catch (e) {
      print("error");
    }
  }

  void _onRmoveUpvote(
    RemoveUpVote event,
    Emitter<ThreadsState> emit,
  ) async {
    try {
      await _threadRepo.downVote(
          threadId: event.threadId, userId: event.userId);
    } catch (e) {
      print("error");
    }
  }

  void _onDoctorsInvolved(
    DoctorsInvolved event,
    Emitter<ThreadsState> emit,
  ) async {}
  void _onAddThread(
    AddThread event,
    Emitter<ThreadsState> emit,
  ) async {
    try {
      await _threadRepo.addThread(
          userId: event.userId, title: event.title, content: event.content);
    } catch (e) {
      print(e.toString());
    }
  }

  void _onUpdateThread(
    UpdateThread event,
    Emitter<ThreadsState> emit,
  ) async {}
  void _onDeleteThread(
    DeleteThread event,
    Emitter<ThreadsState> emit,
  ) async {
    if (this.state is ThreadsLoaded) {
      final state = this.state as ThreadsLoaded;

      try {
        emit(ThreadsLoading());
        await _threadRepo.deleteThread(threadId: event.threadId);
      } catch (e) {
        emit(ThreadsError(err: e.toString()));
      }
    }
  }
}
