import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/model/doctor_model.dart';
import 'package:sanity/repository/doctor_repository/doc_repo.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final DoctorRepository docRepo;
  DoctorBloc({required this.docRepo}) : super(DoctorLoading()) {

    on<RetrieveDoctorsList>(_retrieveDoctor);



  }


  void _retrieveDoctor(RetrieveDoctorsList event,Emitter<DoctorState> emit)async{
    emit(DoctorLoading());
    final Map receivedMap = await docRepo.retrieveLog();
    emit(DoctorListLoaded(docList: receivedMap['doctor_list']));
  }
}
