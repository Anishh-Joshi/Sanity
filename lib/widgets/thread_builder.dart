import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/comment_bloc/comment_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/blocs/threads_bloc/threads_bloc.dart';
import 'package:sanity/model/threads_model.dart';
import 'package:sanity/screens/threads/thread_page.dart';
import 'package:sanity/widgets/circular_progress.dart';
import 'package:sanity/widgets/custom_thread_card.dart';
import 'package:sanity/widgets/platform_aware.dart';

class ThreadBuilder extends StatelessWidget {
  final bool allView;
  final bool profileView;
  const ThreadBuilder(
      {Key? key, required this.profileView, required this.allView})
      : super(key: key);
  Future<void> _confirmDelete(BuildContext context, int threadId) async {
    final didRequest = await const PlatformAADialog(
      title: "Confirm Delete",
      content: "Are you sure you want to delete this thread ?",
      cancelActionText: "Cancel",
      defaultActionText: 'Delete',
    ).show(context);
    if (didRequest) {
      context.read<ThreadsBloc>().add(DeleteThread(threadId: threadId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThreadsBloc, ThreadsState>(
      builder: (context, state) {
        if (state is ThreadsLoaded) {
          return ListView.builder(
            itemCount: allView
                ? state.threads.length
                : state.threads.length > 10
                    ? 10
                    : state.threads.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final ThreadsModel thread = ThreadsModel.fromJSON(
                  response: state.threads[index],
                  userMap: state.owners[index],
                  comments: state.comments,
                  upVotingUserList: state.upVotes);
              return BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoaded) {
                    return !profileView
                        ? InkWell(
                            onLongPress: () {
                              thread.ownerInfo.userId == state.user!.userId
                                  ? _confirmDelete(context, thread.threadId)
                                  : null;
                            },
                            onTap: () {
                              context.read<CommentBloc>().add(
                                  FetchCommentsAndReplies(
                                      threadId: thread.threadId));
                              Navigator.pushNamed(
                                  context, ThreadsDetails.routeName,
                                  arguments: {
                                    "thread": thread,
                                    "user": state.user!
                                  });
                            },
                            child: ThreadCard(
                              thread: thread,
                              userId: state.user!.userId!,
                            ),
                          )
                        : state.user!.userId == thread.ownerInfo.userId
                            ? InkWell(
                                onLongPress: () {
                                  thread.ownerInfo.userId == state.user!.userId
                                      ? _confirmDelete(context, thread.threadId)
                                      : null;
                                },
                                onTap: () {
                                  context.read<CommentBloc>().add(
                                      FetchCommentsAndReplies(
                                          threadId: thread.threadId));
                                  Navigator.pushNamed(
                                      context, ThreadsDetails.routeName,
                                      arguments: {
                                        "thread": thread,
                                        "user": state.user!
                                      });
                                },
                                child: ThreadCard(
                                  thread: thread,
                                  userId: state.user!.userId!,
                                ),
                              )
                            : const SizedBox();
                  }
                  return const SizedBox();
                },
              );
            },
          );
        }

        return const CircularProgressIndicatorCustom();
      },
    );
  }
}
