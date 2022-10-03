class UpvotesModel {
  final int upVoteOwner;
  final int threadId;
  final int upVoteId;

  UpvotesModel(
      {required this.upVoteOwner,
      required this.threadId,
      required this.upVoteId});

  factory UpvotesModel.fromJSON({required Map res}) {
    return UpvotesModel(
        upVoteOwner: res['by_user'],
        threadId: res['thread_upvote_fk'],
        upVoteId:res['thread_upvote_id'] );
  }
}
