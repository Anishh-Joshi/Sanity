part of 'therapy_bloc.dart';

abstract class TherapyEvent extends Equatable {
  const TherapyEvent();

  @override
  List<Object> get props => [];
}

class GetAllTherapy extends TherapyEvent {}

class AddTherapyData extends TherapyEvent {
  final int docId;
  final String category;
  final String title;
  final String contents;

  const AddTherapyData(
      {required this.docId,
      required this.category,
      required this.title,
      required this.contents});
  @override
  List<Object> get props => [docId, category, title, contents];
}

class GetTherapyDetails extends TherapyEvent {
  final int therapyId;
  final List? therapyList;
  final Map? emoteMap;
  final List byDoctor;

  const GetTherapyDetails(
      {required this.byDoctor,
      required this.therapyId,
      this.emoteMap,
      this.therapyList});

  @override
  List<Object> get props => [byDoctor, therapyId, emoteMap!, therapyList!];
}
