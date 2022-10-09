import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/doctor_bloc/doctor_bloc.dart';
import 'package:sanity/blocs/search_bloc/search_bloc.dart';
import 'package:sanity/blocs/therapy/therapy_bloc.dart';
import 'package:sanity/screens/therapy/see_all.dart';
import 'package:sanity/screens/threads/see_all.dart';
import 'package:sanity/screens/write/write_thread.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:sanity/widgets/circular_progress.dart';
import 'package:sanity/widgets/custom_drawer.dart';
import 'package:sanity/widgets/custom_form.dart';
import 'package:sanity/widgets/custom_text_buttons.dart';
import 'package:sanity/widgets/filead_header.dart';
import 'package:sanity/widgets/thread_builder.dart';
import '../../blocs/home/home_bloc.dart';
import '../../model/user_info_model.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/therapy_builder.dart';

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

  Future<void> _refresh(BuildContext context) async {
    refreshKey.currentState?.show(atTop: false);
    context.read<TherapyBloc>().add(GetAllTherapy());
  }

  @override
  Widget build(BuildContext context) {
    final UserInfoModel user =
        ModalRoute.of(context)!.settings.arguments as UserInfoModel;
    FocusManager.instance.primaryFocus?.unfocus();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
    ));
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.pushNamed(
              context,
              WriteThread.routeName,
            );
          },
          child: const Icon(Icons.edit),
        ),
        key: _scaffoldKey,
        body: BlocListener<DoctorBloc, DoctorState>(
          listener: (context, state) {
            if (state is DoctorInfoNull) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                'doc_info',
                arguments: {'user': user, "isNewuser": true},
                (route) => false,
              );
            }
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
                                greetingMessage(),
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
                        SearchTherapy(),
                        const Divider(
                          color: Colors.transparent,
                        ),
                        TextButtonCustom(
                            title: 'Therapies',
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, SeeAllTherapy.routeName);
                            }),
                        const Divider(
                          color: Colors.transparent,
                        ),
                        const TherapyBuilder(allView: false),
                        const Divider(
                          color: Colors.transparent,
                        ),
                        TextButtonCustom(
                          title: "Threads",
                          onPressed: () {
                            Navigator.pushNamed(
                                context, SeeAllThreads.routeName);
                          },
                        ),
                        const Divider(
                          color: Colors.transparent,
                        ),
                        const ThreadBuilder(
                          allView: false,
                        )
                      ],
                    ),
                  ))),
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

class DocInfo extends StatefulWidget {
  static const String routeName = 'doc_info';
  const DocInfo({Key? key}) : super(key: key);
  static Route route(RouteSettings setting) {
    return MaterialPageRoute(
        builder: (context) => const DocInfo(), settings: setting);
  }

  @override
  State<DocInfo> createState() => _DocInfoState();
}

class _DocInfoState extends State<DocInfo> {
  final TextEditingController _degree = TextEditingController();
  final TextEditingController _from = TextEditingController();
  final TextEditingController _tenure = TextEditingController();
  final TextEditingController _major = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    final UserInfoModel user = args['user'];
    return Scaffold(
      floatingActionButton:
          BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeLoaded) {
          return FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<DoctorBloc>().add(AddDocInfo(
                    profileId: state.user!.userId!,
                    isSetting: false,
                    degree: _degree.text,
                    major: _major.text,
                    from: _from.text,
                    tenure: _tenure.text));
              }
            },
            child: Icon(Icons.arrow_forward),
          );
        }
        return const SizedBox();
      }),
      body: BlocListener<DoctorBloc, DoctorState>(
        listener: (context, state) {
          if (state is DoctorListLoaded) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'home_landing', (route) => false,
                arguments: user);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            BlocBuilder<HomeBloc, HomeState>(
                              builder: (context, state) {
                                if (state is HomeLoaded) {
                                  return CircleAvatarCustom(
                                      url: state.user!.profileImgUrl!,
                                      radius: 30);
                                }
                                return const SizedBox();
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Add your Information.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(color: Colors.black),
                                  ),
                                  Text("Helps build trust.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Text("Recent certification.",
                        style: Theme.of(context).textTheme.headline5!),
                    Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14)),
                        width: double.infinity,
                        child: CustomForm(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Degree cannot be blank.';
                            }

                            return null;
                          },
                          hintText: "Eg. M.B.B.S",
                          controller: _degree,
                          borderColor: Colors.transparent,
                          borderRadius: 14,
                          onChanged: (val) {},
                        )),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Text("Major",
                        style: Theme.of(context).textTheme.headline5!),
                    Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14)),
                        width: double.infinity,
                        child: CustomForm(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Major cannot be blank.';
                            }

                            return null;
                          },
                          hintText: "Eg: Psychology.",
                          borderColor: Colors.transparent,
                          borderRadius: 14,
                          controller: _major,
                          onChanged: (val) {},
                        )),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Text("From", style: Theme.of(context).textTheme.headline5!),
                    Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14)),
                        width: double.infinity,
                        child: CustomForm(
                          controller: _from,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'University cannot be blank.';
                            }

                            return null;
                          },
                          hintText: "Eg. Kathmandu University.",
                          borderColor: Colors.transparent,
                          borderRadius: 14,
                          onChanged: (val) {},
                        )),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Text("Tenure (if any)",
                        style: Theme.of(context).textTheme.headline5!),
                    Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14)),
                        width: double.infinity,
                        child: CustomForm(
                          controller: _tenure,
                          validator: (value) {},
                          hintText:
                              " Eg. 5+ y in psychology field and 2+ y in KMC.",
                          borderColor: Colors.transparent,
                          borderRadius: 14,
                          onChanged: (val) {},
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
