part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
  
  @override
  List<Object> get props => [];
}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List notification;

  const NotificationLoaded({required this.notification});

    @override
  List<Object> get props => [notification];
}

class NotificationError extends NotificationState {}
