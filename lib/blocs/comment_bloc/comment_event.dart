part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class Toggle extends CommentEvent{
  final bool isOnComment;
  final Comments? comment;

  Toggle({ this.comment, required this.isOnComment});
    @override
  List<Object> get props => [isOnComment,comment!];


}
