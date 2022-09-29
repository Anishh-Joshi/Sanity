import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/comments_model.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentLoading()) {
    on<Toggle>(_toggle);
  }

  void _toggle(Toggle event, Emitter<CommentState> emit) async {
    if (event.isOnComment) {
      emit(Comment());
    } else {
      emit(Reply(comment: event.comment!));
    }
  }
}
