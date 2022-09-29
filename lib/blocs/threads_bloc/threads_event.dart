part of 'threads_bloc.dart';

abstract class ThreadsEvent extends Equatable {
  const ThreadsEvent();

  @override
  List<Object> get props => [];
}

class FetchAllThreads extends ThreadsEvent {}

class UpVote extends ThreadsEvent {
  final int threadId;
  final int userId;

  const UpVote({required this.threadId, required this.userId});

  @override
  List<Object> get props => [threadId, userId];
}

class RemoveUpVote extends ThreadsEvent {
  final int threadId;
  final int userId;

  const RemoveUpVote({required this.threadId, required this.userId});

  @override
  List<Object> get props => [threadId, userId];
}

class DoctorsInvolved extends ThreadsEvent {}

class AddThread extends ThreadsEvent {
  final String title;
  final String content;
  final int userId;

  const AddThread(
      {required this.userId, required this.title, required this.content});

  @override
  List<Object> get props => [title, content];
}

class UpdateThread extends ThreadsEvent {}

class DeleteThread extends ThreadsEvent {}
