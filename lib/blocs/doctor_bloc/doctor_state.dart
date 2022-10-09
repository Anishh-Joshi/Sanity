part of 'doctor_bloc.dart';

abstract class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object> get props => [];
}

class DoctorLoading extends DoctorState {}

class DoctorListLoaded extends DoctorState {
  final List? docList;
  final DoctorInfoModel? doctorInfo;
  const DoctorListLoaded({
    this.docList,
    this.doctorInfo
  });

  @override
  List<Object> get props => [doctorInfo!, docList!];
}

class DoctorInfoNull extends DoctorState {}
