part of 'therapy_bloc.dart';

abstract class TherapyState extends Equatable {
  const TherapyState();

  @override
  List<Object> get props => [];
}

class TherapyLoading extends TherapyState {}

class TherapyLoaded extends TherapyState {
  final List? therapyList;
  final Map? emoteMap;
  final Map? raw;
  final List byDoctor;
  final TherapyDetailsModel? therapydetails;

  const TherapyLoaded({required this.byDoctor, this.therapydetails, this.therapyList, this.emoteMap,this.raw});
   @override
  List<Object> get props => [therapyList!,byDoctor,emoteMap!,therapyList!,raw!];

}

class TherapyError extends TherapyState {
  final String err;

  const TherapyError({required this.err});

  @override
  List<Object> get props => [err];
}


class TherapyAdditionSuccess extends TherapyState {
}

