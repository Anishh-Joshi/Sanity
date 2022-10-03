import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repository/threads_repository/threds_repo.dart';
part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ThreadsRepo _threadRepo;

  CommentBloc({required ThreadsRepo threadRepo})
      : _threadRepo = threadRepo,
        super(CommentLoading()) {
    on<FetchCommentsAndReplies>(_fetchCommentsAndReplies);
    on<Toggle>(_toggleToReply);
    on<CommentOnThread>(_onCommentOnThread);
    on<ReplyOnThread>(_onReplyOnThread);
    on<RemoveComment>(_removeComment);
    on<RemoveReply>(_removeReply);
  }

  void _fetchCommentsAndReplies(
      FetchCommentsAndReplies event, Emitter<CommentState> emit) async {

    try {
      final Map threadComments =
          await _threadRepo.getComments(threadId: event.threadId);
      emit(CommentLoaded(
        isCommentMode: true,
        comments: threadComments['comment'],
      ));
    } catch (e) {
      print(e.toString());
      emit(CommentError(err: e.toString()));
    }
  }

  void _toggleToReply(Toggle event, Emitter<CommentState> emit) async {
    if (this.state is CommentLoaded) {
      final state = this.state as CommentLoaded;
      emit(CommentLoading());
      try {
        if (event.isCommentMode) {
          emit(CommentLoaded(
              comments: state.comments,
              isCommentMode: event.isCommentMode,
              replyName: event.replyName));
        } else {
          emit(CommentLoaded(
              comments: state.comments,
              commentId: event.commentId!,
              isCommentMode: event.isCommentMode,
              replyName: event.replyName));
        }
      } on Exception {
        emit(const CommentError(err: 'err'));
      }
    }
  }

  void _onCommentOnThread(
      CommentOnThread event, Emitter<CommentState> emit) async {
    if (this.state is CommentLoaded) {
      final state = this.state as CommentLoaded;
      emit(CommentLoading());
      try {
        await _threadRepo.addComment(
            userId: event.userId,
            comment: event.comment,
            threadId: event.threadId);
        emit(CommentLoaded(
          comments: state.comments,
          isCommentMode: true,
        ));
      } on Exception {
        emit(const CommentError(err: 'err'));
      }
    }
  }

  void _removeComment(RemoveComment event, Emitter<CommentState> emit) async {
    if (this.state is CommentLoaded) {
      final state = this.state as CommentLoaded;
      emit(CommentLoading());
      try {
        await _threadRepo.deleteComment(commentId: event.commentId);
        emit(CommentLoaded(
          comments: state.comments,
          isCommentMode: true,
        ));
      } on Exception {
        emit(const CommentError(err: 'err'));
      }
    }
  }

  void _removeReply(RemoveReply event, Emitter<CommentState> emit) async {
    if (this.state is CommentLoaded) {
      final state = this.state as CommentLoaded;
      emit(CommentLoading());
      try {
        await _threadRepo.deleteReply(replyId: event.replyId);
        emit(CommentLoaded(
          comments: state.comments,
          isCommentMode: true,
        ));
      } on Exception {
        emit(CommentError(err: 'err'));
      }
    }
  }

  void _onReplyOnThread(ReplyOnThread event, Emitter<CommentState> emit) async {
    if (this.state is CommentLoaded) {
      final state = this.state as CommentLoaded;
      emit(CommentLoading());
      try {
        print(event.commentId);
        await _threadRepo.addReply(
            reply: event.reply,
            userId: event.userId,
            threadId: event.threadId,
            commentId: event.commentId);
        emit(CommentLoaded(
          comments: state.comments,
          isCommentMode: true,
        ));
      } on Exception {
        emit(CommentError(err: 'err'));
      }
    }
  }
}
