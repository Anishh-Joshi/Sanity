import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sanity/blocs/profile_bloc/profile_bloc.dart';
import 'package:sanity/model/user_info_model.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:sanity/widgets/mapper.dart';
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
  bool preview = false;
  String previewString = "";
  double score = 0.0;

  @override
  void initState() {
    selectedMonth = getSelectedMonth();
    super.initState();
  }

 

  Color determineColor(double value) {
    if (value > 0 && value < 0.5) {
      return const Color(0xff08E48F);
    } else if (value > 0.5 && value < 0.85) {
      return Colors.amber;
    } else if (value > 0.85) {
      return const Color(0xffFF9696);
    }
    return Theme.of(context).cardColor;
  }

  int getSelectedMonth() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    return int.parse(formatted.split("-")[1]);
  }

  determineState(Map map, index) {
    print("HERE");
    print("selectted month$selectedMonth");
    print(index);
    print(map);
    print("SEARCH KEY $selectedMonth-${index.toString().padLeft(2, '0')}");
    return map.containsKey('$selectedMonth-${index.toString().padLeft(2, '0')}');
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
        listener: (context, state) {},
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
                        state.entries > 1
                            ? "${state.entries} Logs"
                            : "${state.entries} Log",
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
                                          icon: const Icon(Icons.arrow_back)),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
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
                                    child: preview
                                        ? Container(
                                            decoration: BoxDecoration(
                                                color: determineColor(score),
                                                borderRadius:
                                                    BorderRadius.circular(14)),
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Opacity(
                                                        opacity: 0,
                                                        child:
                                                            Icon(Icons.home)),
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            preview = false;
                                                            previewString = "";
                                                            score = 0.0;
                                                          });
                                                        },
                                                        icon: const Icon(
                                                            Icons.cancel))
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          bottom: 20.0),
                                                  child: Text(
                                                      previewString == ""
                                                          ? "Log for this day is Empty."
                                                          : previewString,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4),
                                                ),
                                              ],
                                            ))
                                        : GridView.count(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            crossAxisCount: 7,
                                            children: List.generate(
                                                mapper[selectedMonth]['days']+1,
                                                (index) {
                                              return index==0?const Text(""): InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                onTap: () {

                                                  setState(() {
                                                    score = state.timelineLog![
                                                            '$selectedMonth-${index.toString().padLeft(2, '0')}']
                                                        ['score'];
                                                    preview = true;
                                                    previewString = determineState(
                                                            state.timelineLog!,
                                                            index)
                                                        ? state.timelineLog![
                                                                '$selectedMonth-${index.toString().padLeft(2, '0')}']
                                                            ['log']
                                                        : "";
                                                  });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: determineState(
                                                                state
                                                                    .timelineLog!,
                                                                index)
                                                            ? determineColor(
                                                                state.timelineLog![
                                                                        '$selectedMonth-${index.toString().padLeft(2, '0')}']
                                                                    ['score'])
                                                            : Theme.of(context)
                                                                .cardColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Center(
                                                        child: Text(
                                                            '${index.toString().padLeft(2, '0')}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline2!
                                                                .copyWith(
                                                                    fontSize:
                                                                        15,
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        99,
                                                                        97,
                                                                        97)))),
                                                  ),
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
