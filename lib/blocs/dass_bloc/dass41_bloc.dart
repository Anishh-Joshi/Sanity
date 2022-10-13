import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sanity/repository/das_repository/das_repo.dart';

part 'dass41_event.dart';
part 'dass41_state.dart';

class Dass41Bloc extends Bloc<Dass41Event, Dass41State> {
  final DasRepo repo;
  Dass41Bloc({required this.repo}) : super(Dass41Initial()) {
    on<GetDas>(_getDas);
    on<SendDas>(_sendDas);
    on<GetDasResponse>(_getDasResponse);
  }

  List responseSheet = [];

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

  void _getDasResponse(GetDasResponse event, Emitter<Dass41State> emit) async {
    try {
      emit(Dass41Initial());
      final Map response = await repo.getAnswers(profileId: event.profileId);
      final Map ques = await repo.getDass();
      emit(PdfRequested(
          questionsPdf: ques['dass'],
          created_at: response['answers'][0]['created_at'],
          answers: response['answers'][0]['response'],
          category: response['answers'][0]['category']));
    } catch (e) {
      print('error hahahha');
      print(e.toString());
    }
  }

  void _sendDas(SendDas event, Emitter<Dass41State> emit) async {
    List answers = [];

    var sortedByKeyMap = Map.fromEntries(event.responseSheet.entries.toList()
      ..sort((e1, e2) => e1.key.compareTo(e2.key)));
    var sortedByKeyMap2 = Map.fromEntries(event.anotherrespone.entries.toList()
      ..sort((e1, e2) => e1.key.compareTo(e2.key)));
    try {
      sortedByKeyMap.forEach((key, value) {
        answers.add(value);
      });
      sortedByKeyMap2.forEach((key, value) {
        answers.add(value);
      });

      if (state is Dass41Loaded) {
        final state = this.state as Dass41Loaded;
        emit(Dass41Initial());
        final Map response = await repo.setAnswer(event.profileId, answers);
        emit(Dass41Loaded(
            questions: state.questions,
            termsAndConditions: state.termsAndConditions,
            
            category: response['answers']['category'].toString()));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
