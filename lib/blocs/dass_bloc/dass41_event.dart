part of 'dass41_bloc.dart';

abstract class Dass41Event extends Equatable {
  const Dass41Event();

  @override
  List<Object> get props => [];
}

class GetDas extends Dass41Event {
  final bool check;

  const GetDas({
    required this.check,
  });
  @override
  List<Object> get props => [check];
}

class SendDas extends Dass41Event {
  final Map responseSheet;
  final int profileId;
  final Map anotherrespone;

  const SendDas(
      {required this.anotherrespone,
      required this.responseSheet,
      required this.profileId});
  @override
  List<Object> get props => [anotherrespone, responseSheet, profileId];
}
