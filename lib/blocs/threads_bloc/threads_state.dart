part of 'threads_bloc.dart';

abstract class ThreadsState extends Equatable {
  const ThreadsState();

  @override
  List<Object> get props => [];
}

class ThreadsLoading extends ThreadsState {}

class ThreadsLoaded extends ThreadsState {
  final List threads;
  final List owners;
  final List comments;
  final List upVotes;

  const ThreadsLoaded(
      {
      required this.upVotes,
      required this.comments,
      required this.threads,
      required this.owners});
  @override
  List<Object> get props => [threads, owners];
}

class ThreadsError extends ThreadsState {
  final String err;

  const ThreadsError({required this.err});
  @override
  List<Object> get props => [err];
}
