part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileFetched extends ProfileState {
  final UserInfoModel user;
  final int activeThreads;
  final int entries;
  final List? logs;
  final List threads;
  final List owners;
  final List comments;
  final List upVotes;
  final Map? timelineLog;


  const ProfileFetched(
      {this.logs,
       required this.upVotes,
       this.timelineLog,
      required this.comments,
      required this.threads,
      required this.owners,
      required this.user,
      required this.activeThreads,
      required this.entries});

  @override
  List<Object> get props => [timelineLog!, threads,owners,upVotes,comments, logs!, user, activeThreads, entries];
}

class ProfileError extends ProfileState {}
