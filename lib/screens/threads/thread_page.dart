import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:sanity/blocs/comment_bloc/comment_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/blocs/threads_bloc/threads_bloc.dart';
import 'package:sanity/model/comments_model.dart';
import 'package:sanity/model/replies_model.dart';
import 'package:sanity/model/user_info_model.dart';
import 'package:sanity/widgets/circular_progress.dart';
import 'package:sanity/widgets/custom_form.dart';
import 'package:sanity/widgets/platform_aware.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:sanity/widgets/circle_avatar.dart';
import '../../apis/utf_converter.dart';
import '../../model/threads_model.dart';

class ThreadsDetails extends StatefulWidget {
  static const String routeName = 'threads_details';
  const ThreadsDetails({Key? key}) : super(key: key);
  static Route route(RouteSettings setting) {
    return MaterialPageRoute(
        builder: (context) => const ThreadsDetails(), settings: setting);
  }

  @override
  State<ThreadsDetails> createState() => _ThreadsDetailsState();
}

class _ThreadsDetailsState extends State<ThreadsDetails> {
  final TextEditingController _reply = TextEditingController();
  final TextEditingController _comment = TextEditingController();

  int? highlight;

  Future<void> _confirmDelete(BuildContext context, int commentId,int threadId) async {
    final didRequest = await const PlatformAADialog(
      title: "Confirm Delete",
      content: "Are you sure you want to delete this comment ?",
      cancelActionText: "Cancel",
      defaultActionText: 'Delete',
    ).show(context);
    if (didRequest) {
      context.read<CommentBloc>().add(RemoveComment(commentId: commentId,threadId: threadId));
    }
    setState(() {
      highlight = null;
    });
  }

  Future<void> sendComment({required bool isDoctor, required int threadId, required int userId}) async {
    context.read<CommentBloc>().add(CommentOnThread(
          comment: _comment.text,
          userId: userId,
          threadId: threadId,
        ));

  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Map threadMap = ModalRoute.of(context)!.settings.arguments as Map;
    final ThreadsModel thread = threadMap['thread'];
    final UserInfoModel user = threadMap['user'];

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: height,
          margin: const EdgeInsets.only(bottom: 1),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ),
                              Text(
                                thread.ownerInfo.fullName!,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              Text(
                                timeago.format(thread.createdAt,
                                    locale: 'en_short'),
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.transparent,
                        ),
                        SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatarCustom(
                                  url: thread.ownerInfo.profileImgUrl!,
                                  radius: height * 0.06),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  Converter.utf8convert(thread.title),
                                  style:
                                      Theme.of(context).textTheme.headline3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.transparent,
                        ),
                        Text(
                          Converter.utf8convert(thread.contents),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const Divider(
                          color: Colors.transparent,
                        ),
                        BlocBuilder<CommentBloc, CommentState>(
                          builder: (context, state) {
                            if (state is CommentLoading) {
                              return const SizedBox();
                            }

                            if (state is CommentLoaded) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 40.0),
                                child: ListView.builder(
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.comments.length,
                                  itemBuilder: (context, index) {
                                    final Comments comment =
                                        Comments.fromJSONdetail(
                                            response: state.comments[index]);
                                    return GestureDetector(
                                        onLongPress: () {
                                          comment.commentOwner!.userId ==
                                                  user.userId!
                                              ? _confirmDelete(
                                                  context, comment.commentId,thread.threadId)
                                              : null;
                                        },
                                        child: CommentBox(
                                          thread: thread,
                                          color: Colors.transparent,
                                          comment: comment,
                                          height: height,
                                          userId: user.userId!,
                                        ));
                                  },
                                ),
                              );
                            }

                            return const CircularProgressIndicatorCustom();
                          },
                        )
                      ],
                    )),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    color: Theme.of(context).cardColor,
                    width: width,
                    child: Row(
                      children: [
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is HomeLoaded) {
                              return CircleAvatarCustom(
                                  url: state.user!.profileImgUrl!,
                                  radius: 20);
                            }
                            return const SizedBox();
                          },
                        ),
                        BlocBuilder<CommentBloc, CommentState>(
                          builder: (context, state) {
                            if (state is CommentLoading) {
                              return const SizedBox();
                            }

                            if (state is CommentLoaded) {
                              return Expanded(
                                child: CustomForm(
                                    maxLines: null,
                                    controller: state.isCommentMode
                                        ? _comment
                                        : _reply,
                                    borderColor: Colors.transparent,
                                    borderRadius: 10,
                                    hintText: state.isCommentMode
                                        ? " Comment on ${thread.ownerInfo.fullName}'s thread."
                                        : " Reply on ${state.replyName}'s comment."),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                        BlocBuilder<CommentBloc, CommentState>(
                          builder: (context, state) {
                            if (state is CommentLoading) {
                              return const SizedBox();
                            }

                            if (state is CommentLoaded) {
                              return TextButton(
                                  onPressed: () {
                                    if (state.isCommentMode) {
                                      sendComment(
                                        isDoctor: user.isDoctor!,
                                          threadId: thread.threadId,
                                          userId: user.userId!);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Commented on ${thread.ownerInfo.fullName}'s thread.")));
                                      _comment.clear();
                                    } else if (!state.isCommentMode) {
                                      context.read<CommentBloc>().add(
                                          ReplyOnThread(
                                              commentId: state.commentId!,
                                              reply: _reply.text,
                                              userId: user.userId!,
                                              threadId: thread.threadId));
                                      setState(() {});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Replied on ${state.replyName}'s comment.")));

                                      _reply.clear();
                                    }
                                  },
                                  child: state.isCommentMode
                                      ? const Text("Post")
                                      : Row(
                                          children: [
                                            const Text("Reply"),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    context
                                                        .read<CommentBloc>()
                                                        .add(Toggle(
                                                            isCommentMode:
                                                                true));
                                                  });
                                                },
                                                icon: const Icon(
                                                    Fontisto.close))
                                          ],
                                        ));
                            }
                            return const SizedBox();
                          },
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class CommentBox extends StatefulWidget {
  const CommentBox({
    Key? key,
    required this.thread,
    required this.color,
    required this.comment,
    required this.height,
    required this.userId,
  }) : super(key: key);

  final ThreadsModel thread;
  final Comments comment;
  final double height;
  final Color color;
  final int userId;

  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  List getReplies(List replies) {
    var filtered = replies
        .where((reply) => reply.commentId == widget.comment.commentId)
        .toList();
    return filtered;
  }

  Comments? selectedComment;

  bool expand = false;
  int? highlight;

  Future<void> _confirmDelete(BuildContext context, int replyId,int threadId) async {
    final didRequest = await const PlatformAADialog(
      title: "Confirm Delete",
      content: "Are you sure you want to delete this reply ?",
      cancelActionText: "Cancel",
      defaultActionText: 'Delete',
    ).show(context);
    if (didRequest) {
      context.read<CommentBloc>().add(RemoveReply(replyId: replyId,threadId: threadId));
    }
    setState(() {
      highlight = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
            color: widget.color, borderRadius: BorderRadius.circular(14)),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatarCustom(
                      url: widget.comment.commentOwner!.profileImgUrl!,
                      radius: widget.height * 0.03),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.comment.commentOwner!.fullName!,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontSize: 15),
                          ),
                          Text(
                            timeago.format(widget.comment.createdAt),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 11),
                          ),
                          Text(
                            widget.comment.comment,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      expand = true;
                      context.read<CommentBloc>().add(Toggle(
                          isCommentMode: false,
                          commentId: widget.comment.commentId,
                          replyName: widget.comment.commentOwner!.fullName));
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Column(
                      children: [
                        expand
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: widget.comment.replies!.length,
                                itemBuilder: (context, index) {
                                  final RepliyModel reply =
                                      RepliyModel.fromJSON(
                                          response:
                                              widget.comment.replies![index]);
                                  return GestureDetector(
                                      onLongPress: () {
                                        reply.replyOwner!.userId ==
                                                widget.userId
                                            ? _confirmDelete(
                                                context, reply.replyId!,widget.thread.threadId)
                                            : null;
                                      },
                                      child: ReplyCard(
                                          color: Colors.transparent,
                                          reply: reply,
                                          userId: widget.userId,
                                          height: widget.height));
                                })
                            : Text(
                                "Show  Replies",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        fontSize: 12,
                                        color: Theme.of(context).primaryColor),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  height: 1,
                  color: widget.color == Theme.of(context).primaryColor
                      ? Colors.transparent
                      : Theme.of(context).cardColor),
            ])),
      ),
    ]);
  }
}

class ReplyCard extends StatelessWidget {
  const ReplyCard(
      {Key? key,
      required this.color,
      required this.reply,
      required this.userId,
      required this.height})
      : super(key: key);

  final RepliyModel reply;
  final double height;
  final Color color;
  final int userId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.only(left: 40),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatarCustom(
                      url: reply.replyOwner!.profileImgUrl!,
                      radius: height * 0.02),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reply.replyOwner!.fullName!,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontSize: 13),
                          ),
                          Text(
                            timeago.format(reply.createdAt!),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 10),
                          ),
                          Text(
                            reply.reply!,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
