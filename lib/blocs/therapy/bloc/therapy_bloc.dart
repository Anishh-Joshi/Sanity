import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/model/therapy_model.dart';
import 'package:sanity/repository/therapy_repository/therapy_repo.dart';

part 'therapy_event.dart';
part 'therapy_state.dart';

class TherapyBloc extends Bloc<TherapyEvent, TherapyState> {
  final TherapyRepository repo;
  TherapyBloc({required this.repo}) : super(TherapyLoading()) {
    on<GetAllTherapy>(_getAllTherapy);
  }

  void _getAllTherapy(GetAllTherapy event, Emitter<TherapyState> emit) async {
    emit(TherapyLoading());
    try {
      final Map therapy = await repo.getAllTherapy();
      print(therapy);
      emit(TherapyLoaded(therapyList: therapy['therapy_data'],emoteMap: therapy['categories']));
    } catch (e) {
      emit(TherapyError(err: e.toString()));

    }
  }
}
