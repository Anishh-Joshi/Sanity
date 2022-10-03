part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentLoading extends CommentState {}
class ReplyLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final bool isCommentMode;
  final List comments;
  final String? replyName;
  final int? commentId;

  const CommentLoaded(
      {required this.isCommentMode,
      this.replyName,
      this.commentId,
       required this.comments,
       });

  @override
  List<Object> get props => [commentId!, replyName!, isCommentMode, comments,];
}

class CommentError extends CommentState {
  final String err;

  const CommentError({required this.err});
  @override
  List<Object> get props => [err];

}
