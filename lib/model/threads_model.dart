import 'package:sanity/model/comments_model.dart';
import 'package:sanity/model/replies_model.dart';
import 'package:sanity/model/upvotes_model.dart';
import 'package:sanity/model/user_info_model.dart';

class ThreadsModel {
  final int threadId;
  final int threadOwnerId;
  final String title;
  final String contents;
  final DateTime createdAt;
  final UserInfoModel ownerInfo;
  final List<Comments> comments;
  final List<UpvotesModel> upvotingUsers;

  ThreadsModel(
      {required this.threadId,
      required this.comments,
      required this.upvotingUsers,
      required this.threadOwnerId,
      required this.title,
      required this.createdAt,
      required this.contents,
      required this.ownerInfo});

  factory ThreadsModel.fromJSON({
    required Map response,
    required Map userMap,
    required List upVotingUserList,
    required List comments,
  }) {
    List<Comments> commentsModel = [];
    List<RepliyModel> replyModel = [];
    List<UpvotesModel> upVotingUser = [];

    comments.asMap().forEach((index, value) {
      commentsModel.add(Comments.fromJSON(response: comments[index]));
    });

    upVotingUserList.asMap().forEach((index, value) {
      upVotingUser.add(UpvotesModel.fromJSON(res: value));
    });
    return ThreadsModel(
        threadId: response['thread_id'],
        comments: commentsModel,
        upvotingUsers: upVotingUser,
        threadOwnerId: response['added_by_user'],
        title: response['title'],
        createdAt: DateTime.parse(response['created_at']),
        contents: response['content'],
        ownerInfo: UserInfoModel.fromJson(userMap));
  }
}
