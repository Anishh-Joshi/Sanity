import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../repository/appointment_repository/appointment_repo.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final AppointmentRepository repo;
  NotificationBloc({required this.repo}) : super(NotificationLoading()) {
    on<FetchNotifications>(_fetcNotifications);
  }

  void _fetcNotifications(
      FetchNotifications event, Emitter<NotificationState> emit) async {
    print("trigered");
    try {
      emit(NotificationLoading());
      final Map notification = await repo.retrieveAppointmentsNotification(
          userId: event.userId, cat: event.cat);

      notification['notification'].sort((a, b) {
        return DateTime.parse(a["at_time"])
            .compareTo(DateTime.parse(b["at_time"]));
      });
      emit(NotificationLoaded(notification: notification['notification']));
      print("itte");
    } on Exception {
      emit(NotificationError());
    }
  }
}
