import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/repository/das_repository/das_repo.dart';

part 'dass41_event.dart';
part 'dass41_state.dart';

class Dass41Bloc extends Bloc<Dass41Event, Dass41State> {
  final DasRepo repo;
  Dass41Bloc({required this.repo}) : super(Dass41Initial()) {
    on<GetDas>(_getDas);
    on<UpdateDas>(_updateDas);
  }

  void _getDas(GetDas event, Emitter<Dass41State> emit) async {
    try {
      emit(Dass41Initial());
      final Map response = await repo.getDass();

      emit(Dass41Loaded(
          termsAndConditions: event.check, questions: response['dass']));
    } catch (e) {
      print(e.toString());
    }
  }

  void _updateDas(UpdateDas event, Emitter<Dass41State> emit) async {
    print("UPDATED");
    try {
      if (this.state is Dass41Loaded) {
        final state = this.state as Dass41Loaded;
        state.responseSheet!.insert(0, 1);
        emit(Dass41Loaded(
          termsAndConditions: state.termsAndConditions,
          questions: state.questions,
        ));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
