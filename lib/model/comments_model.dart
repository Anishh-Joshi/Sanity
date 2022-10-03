import 'package:sanity/model/replies_model.dart';
import 'package:sanity/model/user_info_model.dart';

class Comments {
  final int commentId;
  final int fk;
  final String comment;
  final DateTime createdAt;
  final UserInfoModel? commentOwner;
  final List? replies;

  Comments(
      {required this.commentId,
      required this.fk,
       this.replies,
      required this.comment,
       this.commentOwner,
      required this.createdAt});

  factory Comments.fromJSON({required Map response}) {
    return Comments(
        commentId: response['thread_comment_id'],
        fk: response['thread_comment_fk']['thread_id'],
        comment: response['comment'],
        replies:response['threads_reply'],
        createdAt: DateTime.parse(response['created_at']));
  }

    factory Comments.fromJSONdetail({required Map response}) {
    return Comments(
        commentId: response['thread_comment_id'],
        replies:response['threads_reply'],
        fk: response['thread_comment_fk']['thread_id'],
        comment: response['comment'],
        commentOwner: UserInfoModel.fromJson(response['by_user']),
        createdAt: DateTime.parse(response['created_at']));
  }

}
