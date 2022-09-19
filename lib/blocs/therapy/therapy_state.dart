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
  final TherapyDetailsModel? therapydetails;

  const TherapyLoaded({this.therapydetails, this.therapyList, this.emoteMap,this.raw});
   @override
  List<Object> get props => [therapyList!,emoteMap!,therapyList!,raw!];

}

class TherapyError extends TherapyState {
  final String err;

  const TherapyError({required this.err});

  @override
  List<Object> get props => [err];
}
