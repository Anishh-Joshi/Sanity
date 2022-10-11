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

class UpdateDas extends Dass41Event {
  final List? responseSheet;
  final  int index;
  const UpdateDas({this.responseSheet,required this.index});
  @override
  List<Object> get props => [responseSheet!,index];
}
