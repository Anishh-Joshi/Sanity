import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/blocs/profile_bloc/profile_bloc.dart';
import 'package:sanity/model/threads_model.dart';
import 'package:sanity/model/user_info_model.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:sanity/widgets/filead_header.dart';
import 'package:sanity/widgets/thread_builder.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = 'profile_page';
  const ProfilePage({Key? key}) : super(key: key);
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) => const ProfilePage(), settings: settings);
  }

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isThreadActive = true;

  @override
  Widget build(BuildContext context) {
    final UserInfoModel user =
        ModalRoute.of(context)!.settings.arguments as UserInfoModel;
    context.read<ProfileBloc>().add(FetchProfile(profileId: user.userId!));
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {},
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileFetched) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarInfo(
                        height: height,
                        onPressed: () {},
                        showDone: false,
                        title: "Profile"),
                    Row(
                      children: [
                        CircleAvatarCustom(
                          url: state.user.profileImgUrl!,
                          radius: height * 0.08,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.user.fullName!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(fontSize: 20),
                            ),
                            Text(
                              "${state.user.age!} years old",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(fontSize: 17),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Text(
                      "Joined on ${DateFormat.yMMMMd().format(state.user.createdAt!)}",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: 16),
                    ),
                    Text(
                      "Active on ${state.activeThreads} threads.",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: 16),
                    ),
                    Text(
                      state.user.address!,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: 16),
                    ),
                    Text(
                      "${state.entries} entries.",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: 16),
                    ),
                    Text(
                      "${state.user.bio ?? ''}",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: 16),
                    ),
                    const Divider(color: Colors.transparent),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(14)),
                      height: height * 0.05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isThreadActive = true;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: isThreadActive
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context).cardColor,
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    child: Center(
                                        child: Text(
                                      "Threads",
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ))),
                              )),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isThreadActive = false;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: !isThreadActive
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context).cardColor,
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    child: Center(
                                        child: Text(
                                      "Timeline view",
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ))),
                              )),
                        ],
                      ),
                    ),
                   const  Divider(color: Colors.transparent,),
                    isThreadActive
                        ? const ThreadBuilder(allView: false, profileView: true)
                        : Container()
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    ));
  }
}
