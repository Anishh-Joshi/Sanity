import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/blocs/therapy/therapy_bloc.dart';
import 'package:sanity/blocs/threads_bloc/threads_bloc.dart';
import 'package:sanity/model/therapy_model.dart';
import 'package:sanity/model/threads_model.dart';
import 'package:sanity/screens/therapy/therapy.dart';
import 'package:sanity/screens/threads/thread_page.dart';
import 'package:sanity/screens/write/write_thread.dart';
import 'package:sanity/widgets/bottom_appbar.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:sanity/widgets/circular_progress.dart';
import 'package:sanity/widgets/custom_drawer.dart';
import 'package:sanity/widgets/custom_form.dart';
import 'package:sanity/widgets/custom_thread_card.dart';
import 'package:sanity/widgets/home_card.dart';
import '../../blocs/comment_bloc/comment_bloc.dart';
import '../../blocs/home/home_bloc.dart';


class Home extends StatefulWidget {
  static const String routeName = 'main_home';
  const Home({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
        builder: (context) => const Home(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String greetingMessage() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return 'Good Morning';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
  // List therapy =

  // List suggestions = [];

  Future<void> _refresh(BuildContext context) async {
    print("here");
    refreshKey.currentState?.show(atTop: false);
    context.read<TherapyBloc>().add(GetAllTherapy());
  }

  // void searchTherapy(String query, List therapy) {
  //   final suggestion = therapy.where((therapy) {
  //     final therapyTitle = therapy.title.toLowerCase();
  //     final input = query.toLowerCase();
  //     return therapyTitle.contains(input);
  //   }).toList();

  //   setState(() {
  //     suggestions = suggestion;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
    ));
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () {
            Navigator.pushNamed(
              context,
              WriteThread.routeName,
            );
          },
          child: Icon(Icons.edit),
        ),
        key: _scaffoldKey,
        bottomNavigationBar: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginAuthenticated) {
              return CustomNavbar(isDoctor: state.user.isDoctor!);
            }
            return const SizedBox();
          },
        ),
        body: RefreshIndicator(
          onRefresh: () => _refresh(context),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SafeArea(
              child: NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                      toolbarHeight: MediaQuery.of(context).size.height * 0.10,
                      automaticallyImplyLeading: false,
                      floating: true,
                      title: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoaded) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${greetingMessage()}",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                Text(
                                  "${state.user!.fullName}",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ],
                            );
                          }
                          return const CircularProgressIndicatorCustom();
                        },
                      ),
                      leading: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoaded) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                child: CircleAvatarCustom(
                                  url: state.user!.profileImgUrl!,
                                  radius: 50,
                                ),
                              ),
                            );
                          }
                          return const CircularProgressIndicatorCustom();
                        },
                      ))
                ],
                body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SafeArea(
                        child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<TherapyBloc, TherapyState>(
                            builder: (context, state) {
                              if (state is TherapyLoaded) {
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: CustomForm(
                                    iconDataSuffix: Icons.clear_rounded,
                                    hintText: "Therapies Eg:Anxeity",
                                    containerColor: Theme.of(context).cardColor,
                                    iconColor: Theme.of(context).canvasColor,
                                    keyboardType: TextInputType.text,
                                    borderColor: Colors.transparent,
                                    iconData: Icons.search,
                                    borderRadius: 20,
                                    onChanged: (val) {
                                      // searchTherapy(val, state.therapyList!);
                                    },
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                          const Divider(
                            color: Colors.transparent,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Therapies",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "See all",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(color: Colors.pink),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.transparent,
                          ),
                          BlocBuilder<TherapyBloc, TherapyState>(
                            builder: (context, state) {
                              if (state is TherapyLoaded) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.therapyList!.length,
                                      itemBuilder: (context, index) {
                                        final TherapyModel therapy =
                                            TherapyModel.fromJSON(
                                                state.therapyList![index],
                                                state.emoteMap!,
                                                state.byDoctor[index]);
                                        return InkWell(
                                          onTap: () {
                                            context.read<TherapyBloc>().add(
                                                GetTherapyDetails(
                                                    byDoctor: state.byDoctor,
                                                    therapyId:
                                                        therapy.therapyId!,
                                                    emoteMap: state.emoteMap,
                                                    therapyList:
                                                        state.therapyList));

                                            Navigator.pushNamed(
                                              context,
                                              Therapy.routeName,
                                              arguments: therapy,
                                            );
                                          },
                                          child: TherapyCard(
                                            therapy: therapy,
                                          ),
                                        );
                                      }),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                          const Divider(
                            color: Colors.transparent,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Threads",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "See all",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(color: Colors.pink),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.transparent,
                          ),
                          BlocBuilder<ThreadsBloc, ThreadsState>(
                            builder: (context, state) {
                              if (state is ThreadsLoaded) {
                                return ListView.builder(
                                  itemCount: state.threads.length > 10
                                      ? 10
                                      : state.threads.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final ThreadsModel thread =
                                        ThreadsModel.fromJSON(
                                            replies: state.replies,
                                            replyOwners: state.replyOwner,
                                            response: state.threads[index],
                                            userMap: state.owners[index],
                                            commentingUserList:
                                                state.commentUsers,
                                            comments: state.comments,
                                            upVotingUserList: state.upVotes);
                                    return BlocBuilder<HomeBloc, HomeState>(
                                      builder: (context, state) {
                                        if (state is HomeLoaded) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  ThreadsDetails.routeName,
                                                  arguments: {
                                                    "thread": thread,
                                                    "userId":
                                                        state.user!.userId!
                                                  });
                                            },
                                            child: ThreadCard(
                                              thread: thread,
                                              userId: state.user!.userId!,
                                            ),
                                          );
                                        }
                                        return const SizedBox();
                                      },
                                    );
                                  },
                                );
                              }

                              return const CircularProgressIndicatorCustom();
                            },
                          ),
                        ],
                      ),
                    ))),
              ),
            ),
          ),
        ),
        drawer: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoaded) {
              return CustomDrawer(
                isDoctor: state.user!.isDoctor!,
                scaffoldKey: _scaffoldKey,
              );
            }
            return const SizedBox();
          },
        ));
  }
}
