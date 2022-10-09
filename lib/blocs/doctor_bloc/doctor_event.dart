part of 'doctor_bloc.dart';

abstract class DoctorEvent extends Equatable {
  const DoctorEvent();

  @override
  List<Object> get props => [];
}

class CheckDocInfo extends DoctorEvent {
  final int profileId;

  const CheckDocInfo({required this.profileId});
  @override
  List<Object> get props => [profileId];
}

class AddDocInfo extends DoctorEvent {
  final int profileId;
  final String? major;
  final String? degree;
  final String? tenure;
  final String? from;
  final bool isSetting;

  const AddDocInfo(
      {this.degree,
      this.from,
      this.major,
      required this.isSetting,
      this.tenure,
      required this.profileId});
  @override
  List<Object> get props =>
      [profileId, major!, degree!, tenure!, from!, isSetting];
}

class RetrieveDoctorsList extends DoctorEvent {}

class RetrieveDoctorsInfo extends DoctorEvent {
  final int profileId;

  const RetrieveDoctorsInfo({required this.profileId});
  @override
  List<Object> get props => [profileId];
}
