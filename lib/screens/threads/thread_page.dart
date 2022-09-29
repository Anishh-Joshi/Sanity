import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:sanity/blocs/comment_bloc/comment_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/blocs/threads_bloc/threads_bloc.dart';
import 'package:sanity/model/comments_model.dart';
import 'package:sanity/model/replies_model.dart';
import 'package:sanity/widgets/custom_form.dart';
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
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Map threadMap = ModalRoute.of(context)!.settings.arguments as Map;
    final ThreadsModel thread = threadMap['thread'];
    final int userId = threadMap['userId'];
    return Scaffold(
      body: SafeArea(
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
                              child: Container(
                                child: Text(
                                  Converter.utf8convert(thread.title),
                                  style: Theme.of(context).textTheme.headline3,
                                ),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: thread.comments.length,
                          itemBuilder: (context, index) {
                            return CommentBox(
                                comment: thread.comments[index],
                                thread: thread,
                                height: height);
                          },
                        ),
                      )
                    ],
                  )),
            ),
            BlocBuilder<CommentBloc, CommentState>(
              builder: (context, st) {
                if (st is Comment) {
                  return Positioned(
                      bottom: 0,
                      child: Container(
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
                            Expanded(
                              child: CustomForm(
                                  maxLines: null,
                                  controller: _comment,
                                  borderColor: Colors.transparent,
                                  borderRadius: 10,
                                  hintText:
                                      "Comment on ${thread.ownerInfo.fullName}'s thread"),
                            ),
                            TextButton(
                                onPressed: () {
                                  context
                                      .read<ThreadsBloc>()
                                      .add(CommentOnThread(
                                        comment: _comment.text,
                                        userId: userId,
                                        threadId: thread.threadId,
                                      ));
                                  _comment.clear();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Commented on ${thread.ownerInfo.fullName}'s thread.")));
                                },
                                child: const Text("Post")),
                          ],
                        ),
                      ));
                } else if (st is Reply) {
                  return Positioned(
                      bottom: 0,
                      child: Container(
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
                            Expanded(
                              child: CustomForm(
                                  maxLines: null,
                                  controller: _reply,
                                  borderColor: Colors.transparent,
                                  borderRadius: 10,
                                  hintText:
                                      "Reply to ${st.comment.commentOwner.fullName} 's comment."),
                            ),
                            TextButton(
                                onPressed: () {
                                  context.read<ThreadsBloc>().add(ReplyOnThread(
                                      reply: _reply.text,
                                      userId: userId,
                                      threadId: thread.threadId,
                                      commentId: st.comment.commentId));
                                },
                                child: const Text("Reply")),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<CommentBloc>()
                                        .add(Toggle(isOnComment: true));
                                  },
                                  child: const Icon(FontAwesome.remove)),
                            )
                          ],
                        ),
                      ));
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CommentBox extends StatefulWidget {
  const CommentBox({
    Key? key,
    required this.thread,
    required this.comment,
    required this.height,
  }) : super(key: key);

  final ThreadsModel thread;
  final Comments comment;
  final double height;

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

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatarCustom(
                    url: widget.thread.ownerInfo.profileImgUrl!,
                    radius: widget.height * 0.03),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.comment.commentOwner.fullName!,
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
            getReplies(widget.thread.replies).length == 0
                ? const SizedBox()
                : Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedComment = widget.comment;
                          expand = true;
                          context.read<CommentBloc>().add(Toggle(
                              isOnComment: false, comment: widget.comment));
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Column(
                          children: [
                            expand
                                ? const SizedBox()
                                : Text(
                                    "Show ${getReplies(widget.thread.replies).length} Replies",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            fontSize: 12,
                                            color:
                                                Theme.of(context).primaryColor),
                                  ),
                            expand
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: getReplies(widget.thread.replies)
                                        .length,
                                    itemBuilder: (context, index) {
                                      return ReplyCard(
                                          height: widget.height,
                                          reply: getReplies(
                                              widget.thread.replies)[index]);
                                    })
                                : const SizedBox(),
                            expand
                                ? Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          expand = false;
                                        });
                                      },
                                      child: Text(
                                        "Hide ${getReplies(widget.thread.replies).length} Replies",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
            Container(height: 1, color: Theme.of(context).cardColor),
          ])),
    ]);
  }
}

class ReplyCard extends StatelessWidget {
  const ReplyCard({Key? key, required this.reply, required this.height})
      : super(key: key);

  final RepliyModel reply;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        margin: const EdgeInsets.only(left: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatarCustom(
                    url: reply.replyOwner.profileImgUrl!,
                    radius: height * 0.02),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reply.replyOwner.fullName!,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontSize: 13),
                        ),
                        Text(
                          timeago.format(reply.createdAt),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 10),
                        ),
                        Text(
                          reply.reply,
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
    );
  }
}
