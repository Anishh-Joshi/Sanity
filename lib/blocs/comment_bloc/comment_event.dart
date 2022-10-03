part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class FetchCommentsAndReplies extends CommentEvent {
  final int threadId;
  final int? commentId;

  const FetchCommentsAndReplies({required this.threadId, this.commentId});
  @override
  List<Object> get props => [threadId, commentId!];
}


class Reload extends CommentEvent {
  final int threadId;

  const Reload({required this.threadId});
  @override
  List<Object> get props => [threadId];
}

class Toggle extends CommentEvent {
  final bool isCommentMode;
  final String? replyName;
  final int?commentId; 

  Toggle({this.commentId, required this.isCommentMode, this.replyName});
  @override
  List<Object> get props => [commentId!,replyName!, isCommentMode];
}

class CommentOnThread extends CommentEvent {
  final String comment;
  final int userId;
  final int threadId;

  const CommentOnThread(
      {required this.comment, required this.userId, required this.threadId});

  @override
  List<Object> get props => [comment, userId, threadId];
}

class ReplyOnThread extends CommentEvent {
  final String reply;
  final int userId;
  final int threadId;
  final int commentId;

  const ReplyOnThread(
      {required this.reply,
      required this.userId,
      required this.threadId,
      required this.commentId});

  @override
  List<Object> get props => [reply, userId, threadId, commentId];
}

class RemoveComment extends CommentEvent {
  final int commentId;

  const RemoveComment({required this.commentId});
  @override
  List<Object> get props => [commentId];
}

class RemoveReply extends CommentEvent {
  final int replyId;


  const RemoveReply({required this.replyId});

  @override
  List<Object> get props => [replyId];
}
