import 'package:sanity/model/user_info_model.dart';

class RepliyModel {
  final int? replyId;
  final int? commentId;
  final String? reply;
  final int? threadId;
  final DateTime? createdAt;
  final UserInfoModel? replyOwner;

  RepliyModel(
      {required this.replyId,
      required this.commentId,
      required this.threadId,
      required this.reply,
      required this.replyOwner,
      required this.createdAt});

  factory RepliyModel.fromJSON({required Map response}) {
    return RepliyModel(
        replyId: response['thread_comment_reply_id'],
        threadId: response['thread_id'],
        commentId: response['thread_reply_fk']['thread_comment_id'],
        reply: response['reply'],
        replyOwner: UserInfoModel.fromJson(response['by_user']),
        createdAt: DateTime.parse(response['created_at']));
  }
}
