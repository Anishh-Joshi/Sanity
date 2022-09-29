import 'package:sanity/model/comments_model.dart';
import 'package:sanity/model/replies_model.dart';
import 'package:sanity/model/user_info_model.dart';

class ThreadsModel {
  final int threadId;
  final int threadOwnerId;
  final String title;
  final int docInvolved;
  final String contents;
  final DateTime createdAt;
  final UserInfoModel ownerInfo;
  final List<Comments> comments;
  final List<RepliyModel> replies;
  final List<UserInfoModel> upvotingUsers;

  ThreadsModel(
      {required this.threadId,
      required this.comments,
      required this.replies,
      required this.upvotingUsers,
      required this.threadOwnerId,
      required this.title,
      required this.createdAt,
      required this.docInvolved,
      required this.contents,
      required this.ownerInfo});

  factory ThreadsModel.fromJSON(
      {required Map response,
      required Map userMap,
      required List upVotingUserList,
      required List comments,
      required List replies,
      required List replyOwners,
      required List commentingUserList}) {
    List<Comments> commentsModel = [];
    List<RepliyModel> replyModel = [];

    List<UserInfoModel> upVotingUser = [];

    comments.asMap().forEach((index, value) {
      commentsModel.add(Comments.fromJSON(
          response: comments[index], owner: commentingUserList[index]));
    });

    replies.asMap().forEach((index, value) {
      replyModel.add(RepliyModel.fromJSON(
          response: replies[index], owner: replyOwners[index]));
    });
    upVotingUserList.asMap().forEach((index, value) {
      upVotingUser.add(UserInfoModel.fromJson(value));
    });
    return ThreadsModel(
        threadId: response['thread_id'],
        comments: commentsModel,
        replies: replyModel,
        upvotingUsers: upVotingUser,
        threadOwnerId: response['added_by_user'],
        title: response['title'],
        createdAt: DateTime.parse(response['created_at']),
        docInvolved: response['docs_involved'],
        contents: response['content'],
        ownerInfo: UserInfoModel.fromJson(userMap));
  }
}
