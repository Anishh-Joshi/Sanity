part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentLoading extends CommentState {}

class Reply extends CommentState {
  final Comments comment;

  Reply({required this.comment});

  @override
  List<Object> get props => [comment];
}

class Comment extends CommentState {

  @override
  List<Object> get props => [];
}
