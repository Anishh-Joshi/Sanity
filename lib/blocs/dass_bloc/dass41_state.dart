part of 'dass41_bloc.dart';

abstract class Dass41State extends Equatable {
  const Dass41State();

  @override
  List<Object> get props => [];
}

class Dass41Initial extends Dass41State {}

class Dass41Loaded extends Dass41State {
  final bool termsAndConditions;
  final List questions;
  List? responseSheet = [];

  Dass41Loaded({required this.questions, required this.termsAndConditions});
  @override
  List<Object> get props => [termsAndConditions, questions, responseSheet!];
}

class Dass41Error extends Dass41State {}
