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
    on<AddTherapyData>(_addTherapy);
  }

  void _getAllTherapy(GetAllTherapy event, Emitter<TherapyState> emit) async {
    emit(TherapyLoading());
    try {
      final Map therapy = await repo.getAllTherapy();
      emit(TherapyLoaded(
          byDoctor: therapy['doc_info'],
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
        byDoctor: event.byDoctor,
        therapydetails:
            TherapyDetailsModel.fromJSON(therapyDetails['therapy_data'][0]),
      ));
    } catch (e) {
      emit(TherapyError(err: e.toString()));
    }
  }
  void _addTherapy(
      AddTherapyData event, Emitter<TherapyState> emit) async {
    emit(TherapyLoading());
    try {
      final Map therapyDetails =
          await repo.addTherapy(event.docId,event.contents, event.category, event.title);
          if(therapyDetails['status']=='success'){
            emit(TherapyAdditionSuccess());
          }
    } catch (e) {
      emit(TherapyError(err: e.toString()));
    }
  }
}
