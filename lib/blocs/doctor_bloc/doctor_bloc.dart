import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/model/doctor_info_model.dart';
import 'package:sanity/model/doctor_model.dart';
import 'package:sanity/repository/doctor_repository/doc_repo.dart';
import 'package:sanity/screens/home/home.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final DoctorRepository docRepo;
  DoctorBloc({required this.docRepo}) : super(DoctorLoading()) {
    on<RetrieveDoctorsList>(_retrieveDoctor);
    on<CheckDocInfo>(_checkDocInfo);
    on<AddDocInfo>(_addDocInfo);
    // on<RetrieveDoctorsInfo>(_retrieveDocInfo);
  }

  void _retrieveDoctor(
      RetrieveDoctorsList event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());
    final Map receivedMap = await docRepo.retrieveLog();
    emit(DoctorListLoaded(docList: receivedMap['doctor_list']));
  }

  // void _retrieveDocInfo(
  //     RetrieveDoctorsInfo event, Emitter<DoctorState> emit) async {
  //   final Map receivedMap =
  //       await docRepo.getDocInfo(profileId: event.profileId);
  //   if (this.state is DoctorListLoaded) {
  //     final state = this.state as DoctorListLoaded;
  //     if (receivedMap['status'] == 'success') {
  //       final DoctorInfoModel doc =
  //           DoctorInfoModel.fromJson(receivedMap['info']);
  //       emit(
  //         DoctorListLoaded(doctorInfo: doc),
  //       );
  //     } else {
  //       emit(DoctorListLoaded(docList: state.docList));
  //     }
  //   }
  // }

  void _checkDocInfo(CheckDocInfo event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());
    final Map receivedMap =
        await docRepo.getDocInfo(profileId: event.profileId);
    if (receivedMap['status'] == 'failed') {
      emit(DoctorInfoNull());
    } else if (receivedMap['status'] == 'success') {
      emit(DoctorListLoaded());
    }
  }

  void _addDocInfo(AddDocInfo event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());
    final Map receivedMap;
    if (event.isSetting) {
      receivedMap = await docRepo.updateDocInfoSettings(
          profileId: event.profileId,
          from: event.from,
          degree: event.degree,
          tenure: event.tenure,
          major: event.major);
    }else{
      receivedMap = await docRepo.updateDocInfo(
          profileId: event.profileId,
          from: event.from,
          degree: event.degree,
          tenure: event.tenure,
          major: event.major);
    }

    if (receivedMap['status'] == 'success') {
      emit(DoctorListLoaded());
    } else {
      emit(DoctorInfoNull());
    }
  }
}
