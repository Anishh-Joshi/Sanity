import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/doctor_bloc/doctor_bloc.dart';
import 'package:sanity/blocs/therapy/therapy_bloc.dart';
import 'package:sanity/screens/therapy/see_all.dart';
import 'package:sanity/screens/threads/see_all.dart';
import 'package:sanity/screens/write/write_thread.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:sanity/widgets/circular_progress.dart';
import 'package:sanity/widgets/custom_drawer.dart';
import 'package:sanity/widgets/custom_form.dart';
import 'package:sanity/widgets/custom_text_buttons.dart';
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
                        const SearchTherapy(),
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
                          profileView: false,
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

