// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/model/therapy_details.dart';
import 'package:sanity/repository/therapy_repository/therapy_repo.dart';
part 'therapy_event.dart';
part 'therapy_state.dart';

class TherapyBloc extends Bloc<TherapyEvent, TherapyState> {
  final TherapyRepository repo;
  TherapyBloc({required this.repo}) : super(TherapyLoading()) {
    on<GetAllTherapy>(_getAllTherapy);
    on<GetTherapyDetails>(_getTherapyDetails);
  }

  void _getAllTherapy(GetAllTherapy event, Emitter<TherapyState> emit) async {
    emit(TherapyLoading());
    try {
      final Map therapy = await repo.getAllTherapy();
      emit(TherapyLoaded(
          therapyList: therapy['therapy_data'],
          emoteMap: therapy['categories']));
    } catch (e) {
      emit(TherapyError(err: e.toString()));
    }
  }

  void _getTherapyDetails(
      GetTherapyDetails event, Emitter<TherapyState> emit) async {
    emit(TherapyLoading());
    try {
      final Map therapyDetails =
          await repo.getTherapyDetails(id: event.therapyId);
      emit(TherapyLoaded(
        emoteMap: event.emoteMap,
        therapyList: event.therapyList,
          therapydetails: TherapyDetailsModel.fromJSON(
              therapyDetails['therapy_data'][0], therapyDetails['doc_info'])));
    } catch (e) {
      print(e.toString());
      emit(TherapyError(err: e.toString()));
    }
  }
}
