part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfile extends ProfileEvent {
  final int profileId;

  const FetchProfile({required this.profileId});
}
