part of 'therapy_bloc.dart';

abstract class TherapyEvent extends Equatable {
  const TherapyEvent();

  @override
  List<Object> get props => [];
}

class GetAllTherapy extends TherapyEvent{

}
