part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}


class FetchNotifications extends NotificationEvent{
  final int userId;
  final String cat;
  const FetchNotifications({required this.cat, required this.userId});
  @override
  List<Object> get props => [cat,userId];


}