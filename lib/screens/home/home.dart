import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/blocs/therapy/therapy_bloc.dart';
import 'package:sanity/model/therapy_model.dart';
import 'package:sanity/screens/therapy/therapy.dart';
import 'package:sanity/widgets/bottom_appbar.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:sanity/widgets/circular_progress.dart';
import 'package:sanity/widgets/custom_drawer.dart';
import 'package:sanity/widgets/custom_form.dart';
import 'package:sanity/widgets/custom_thread_card.dart';
import 'package:sanity/widgets/home_card.dart';
import '../../blocs/home/home_bloc.dart';
import '../../widgets/platform_aware.dart';

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
    print("here");
    refreshKey.currentState?.show(atTop: false);
    context.read<TherapyBloc>().add(GetAllTherapy());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
    ));
    return Scaffold(
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
                          Padding(
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
                              onChanged: (val) {},
                            ),
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
                                                state.emoteMap!);
                                        return InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              Therapy.routeName,
                                              arguments: therapy,
                                            );
                                            context.read<TherapyBloc>().add(
                                                GetTherapyDetails(
                                                    therapyId:
                                                        therapy.therapyId!,
                                                    emoteMap: state.emoteMap,
                                                    therapyList:
                                                        state.therapyList));
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
                          ListView.builder(
                            itemCount: 50,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return const ThreadCard();
                            },
                          ),
                        ],
                      ),
                    ))),
              ),
            ),
          ),
        ),
        drawer: CustomDrawer(
          scaffoldKey: _scaffoldKey,
        ));
  }
}
