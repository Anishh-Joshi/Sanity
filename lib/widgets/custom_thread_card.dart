import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:sanity/apis/utf_converter.dart';
import 'package:sanity/blocs/threads_bloc/threads_bloc.dart';
import 'package:sanity/model/threads_model.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../model/upvotes_model.dart';

class ThreadCard extends StatefulWidget {
  final ThreadsModel thread;
  final int userId;
  const ThreadCard({Key? key, required this.userId, required this.thread})
      : super(key: key);

  @override
  State<ThreadCard> createState() => _ThreadCardState();
}

class _ThreadCardState extends State<ThreadCard> {
  bool totalVotes() {
    List<UpvotesModel> filtered = widget.thread.upvotingUsers
        .where((content) => content.threadId == widget.thread.threadId)
        .toList();

    List<UpvotesModel> upvotesList = filtered
        .where((element) => element.upVoteOwner == widget.userId)
        .toList();

    setState(() {
      upVote = filtered.length;
    });
    return upvotesList.isEmpty ? false : true;
  }

  List getComments() {
    var filtered = widget.thread.comments
        .where((content) => content.fk == widget.thread.threadId)
        .toList();
    return filtered;
  }

  bool isLoading = false;

  List getDocsInvolved() {
    var filtered = widget.thread.comments
        .where((content) => content.commentOwner!.isDoctor == true)
        .toList();
    return filtered;
  }

  List? comment;
  List? docsInvolved;
  List<UpvotesModel>? total;

  @override
  void initState() {
    setState(() {
      comment = getComments();
      isLiked = totalVotes();
      docsInvolved = getDocsInvolved();
    });

    super.initState();
  }

  bool isLiked = false;
  int? upVote;

  void handleUpvote({required int userId, required int threadId}) {
    isLiked
        ? context
            .read<ThreadsBloc>()
            .add(RemoveUpVote(threadId: threadId, userId: userId))
        : context
            .read<ThreadsBloc>()
            .add(UpVote(threadId: threadId, userId: userId));
    setState(() {
      isLiked ? upVote = upVote! - 1 : upVote = upVote = upVote! + 1;
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10)),
      width: double.infinity,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatarCustom(
              radius: 30,
              url: widget.thread.ownerInfo.profileImgUrl!,
            ),
            title: Text(
              Converter.utf8convert(widget.thread.title),
              style: Theme.of(context).textTheme.headline4,
            ),
            trailing: Text(
              timeago.format(widget.thread.createdAt, locale: 'en_short'),
            ),
            subtitle: Text(
              widget.thread.contents.length > 50
                  ? widget.thread.contents.substring(0, 50) + "..."
                  : widget.thread.contents,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesome5.comment_alt,
                    size: 21,
                    color: Color(0xff787878),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    comment!.length.toString(),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Fontisto.doctor,
                    size: 20,
                    color: Color(0xff787878),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    isLoading ? "-" : docsInvolved!.length.toString(),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () => handleUpvote(
                        threadId: widget.thread.threadId,
                        userId: widget.userId),
                    child: Icon(
                      FontAwesome.arrow_circle_up,
                      size: 23,
                      color: !isLiked
                          ? Colors.grey
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    upVote.toString(),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
