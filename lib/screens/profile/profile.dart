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
  int? selectedMonth;

  @override
  void initState() {
    selectedMonth = getSelectedMonth();
    super.initState();
  }

  final Map mapper = {
    1: {"month": "January", "days": 31},
    2: {"month": "February", "days": 28},
    3: {"month": "March", "days": 31},
    4: {"month": "April", "days": 30},
    5: {"month": "May", "days": 31},
    6: {"month": "June", "days": 30},
    7: {"month": "July", "days": 31},
    8: {"month": "August", "days": 31},
    9: {"month": "September", "days": 30},
    10: {"month": "October", "days": 31},
    11: {"month": "November", "days": 30},
    12: {"month": "December", "days": 31},
  };

  int getSelectedMonth() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    return int.parse(formatted.split("-")[1]);
  }

  determineState(Map map, index) {
    return map.containsKey('$selectedMonth-${index + 1}');
  }

  @override
  Widget build(BuildContext context) {
    final UserInfoModel user =
        ModalRoute.of(context)!.settings.arguments as UserInfoModel;
    context.read<ProfileBloc>().add(FetchProfile(profileId: user.userId!));
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFetched) {
            print(state.timelineLog!);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                                color: isThreadActive
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .canvasColor),
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                                color: !isThreadActive
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .canvasColor),
                                      ))),
                                )),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      isThreadActive
                          ? const ThreadBuilder(
                              allView: false, profileView: true)
                          : Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 2.0,
                                    ),
                                  )),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (selectedMonth! > 1) {
                                                selectedMonth =
                                                    selectedMonth! - 1;
                                              }
                                            });
                                          },
                                          icon: Icon(Icons.arrow_back)),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Center(
                                            child: Text(
                                              mapper[selectedMonth]['month'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (selectedMonth! < 12) {
                                                selectedMonth =
                                                    selectedMonth! + 1;
                                              }
                                            });
                                          },
                                          icon:
                                              const Icon(Icons.arrow_forward)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SizedBox(
                                    height: height * 0.32,
                                    child: GridView.count(
                                      crossAxisCount: 8,
                                      children: List.generate(
                                          mapper[selectedMonth]['days'],
                                          (index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: determineState(
                                                        state.timelineLog!,
                                                        index)
                                                    ? state.timelineLog![
                                                                    '$selectedMonth-${index + 1}']
                                                                ['score'] >
                                                            0
                                                        ? Theme.of(context).primaryColor
                                                        : const Color.fromARGB(255, 204, 202, 202)
                                                    : const Color.fromARGB(255, 204, 202, 202),
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ],
                            )
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    ));
  }
}
