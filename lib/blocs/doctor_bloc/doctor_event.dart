part of 'doctor_bloc.dart';

abstract class DoctorEvent extends Equatable {
  const DoctorEvent();

  @override
  List<Object> get props => [];
}


class RetrieveDoctorsList extends DoctorEvent{
  
}