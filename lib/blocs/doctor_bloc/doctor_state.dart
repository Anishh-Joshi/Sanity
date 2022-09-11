part of 'doctor_bloc.dart';

abstract class DoctorState extends Equatable {
  const DoctorState();
  
  @override
  List<Object> get props => [];
}

class DoctorLoading extends DoctorState {}

class DoctorListLoaded extends DoctorState {
  final List docList;
  const DoctorListLoaded({required this.docList,});

  @override
  List<Object> get props =>[docList];

}
