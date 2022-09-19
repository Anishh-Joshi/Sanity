part of 'therapy_bloc.dart';

abstract class TherapyEvent extends Equatable {
  const TherapyEvent();

  @override
  List<Object> get props => [];
}

class GetAllTherapy extends TherapyEvent{

}

class GetTherapyDetails extends TherapyEvent{
  final int therapyId ;
  final List? therapyList;
  final Map? emoteMap;

  const GetTherapyDetails({required this.therapyId,this.emoteMap,this.therapyList});

  @override
  List<Object> get props => [therapyId,emoteMap!,therapyList!];


}
