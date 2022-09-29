import 'package:sanity/model/user_info_model.dart';

class Comments {
  final int commentId;
  final int fk;
  final String comment;
  final DateTime createdAt;
  final UserInfoModel commentOwner;

  Comments(
      {required this.commentId,
      required this.fk,
      required this.comment,
      required this.commentOwner,
      required this.createdAt});

  factory Comments.fromJSON({required Map response, required Map owner}) {
    return Comments(
        commentId: response['thread_comment_id'],
        fk: response['thread_comment_fk'],
        comment: response['comment'],
        commentOwner: UserInfoModel.fromJson(owner),
        createdAt: DateTime.parse(response['created_at']));
  }

}
