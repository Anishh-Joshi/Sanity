import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:sanity/widgets/custom_drawer.dart';
import 'package:sanity/widgets/custom_form.dart';
import 'package:sanity/widgets/custom_thread_card.dart';
import 'package:sanity/widgets/home_card.dart';
import '../../blocs/home/home_bloc.dart';
import '../../widgets/platform_aware.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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


  final List dummyData = [
    {
      "therapy":"I can't Feel the Air",
      "enrolled":179,
      "category":"Depressed",
      "by":"Eldy"
    },
    {
      "therapy":"I feel nervous that my friends hate me!",
      "enrolled":16,
      "category":"Suicidal",
      "by":"Anish"
    },
    {
      "therapy":"Am am just Sad.",
      "enrolled":34,
      "category":"Sad",
      "by":"Ramesh"
    },
    {
      "therapy":"I find it extremly difficult around people.",
      "enrolled":6722,
      "category":"Insecure",
      "by":"Khadka"
    },
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
    ));
    return Scaffold(
        key: _scaffoldKey,
        body: GestureDetector(
          onTap: (){
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
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  leading: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoaded) {
                          return Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: GestureDetector(
                              onTap: (){
                                Scaffold.of(context).openDrawer();
                              },
                              child: CircleAvatarCustom(
                                url: state.user!.profileImgUrl!,
                                radius: 50,
                              ),
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    )
                )
              ],
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SafeArea(
                    child: BlocListener<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is LoginError) {
                            const PlatformAADialog(
                              title: 'Oops',
                              content: "Something Went Wrong!",
                              defaultActionText: "Ok",
                            ).show(context);
                          } else if (state is LoginUnAuthenticated) {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamedAndRemoveUntil(
                                    'landing_page', (route) => false);
                          }
                        },
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: CustomForm(
                                  iconDataSuffix:Icons.clear_rounded ,
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
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 4,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: dummyData.length,
                                    itemBuilder: (context, index) {
                                      return TherapyCard(category: dummyData[index]['category'], by:dummyData[index]['by'] ,enrolled: dummyData[index]['enrolled'],therapy: dummyData[index]['therapy'],);
                                    }),
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
