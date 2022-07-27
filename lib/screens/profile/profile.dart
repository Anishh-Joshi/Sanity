import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:sanity/widgets/custom_appbar.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = 'profile';
  const ProfilePage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const ProfilePage(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        appBarTitle: "Profile",
        iconData: Icons.settings,
        onPressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: topHalf(context: context),
            ),
            Expanded(flex: 1, child: midHalf(context: context)),
            Expanded(flex: 6, child: bottomHalf(context: context)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.black,
          child: const Icon(Icons.edit)),
    );
  }

  Widget midHalf({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 1,
          child: Text("Goals",
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontSize: 18)),
        ),
        Flexible(
            flex: 1,
            child: Text(
              "Timeline",
              style:
                  Theme.of(context).textTheme.headline4!.copyWith(fontSize: 18),
            )),
        Flexible(
            flex: 1,
            child: Text("Badges",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontSize: 18)))
      ],
    );
  }

  Container bottomHalf({required BuildContext context}) {
    return Container(
      height: MediaQuery.of(context).size.height,
    );
  }

  SizedBox topHalf({required BuildContext context}) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoaded) {
                  return CircleAvatarCustom(
                      url: state.user!.profileImgUrl!,
                      radius: MediaQuery.of(context).size.height / 15);
                }
                // yelai chai pacchi shimmer effect le replace handiney
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoaded) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.user!.fullName!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(fontSize: 20)),
                          Text(
                            "${state.user!.age!.toString()} years old",
                            style: Theme.of(context).textTheme.headline5,
                          )
                        ]);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Joined on 1st July",
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: const Color(0xff787878))),
                Text("Active on 20 threads",
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: const Color(0xff787878))),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoaded) {
                      return Text("Kathmandu University",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: const Color(0xff787878)));
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                Text("42 Entries",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: const Color(0xff787878))),
              ],
            )
          ])
        ],
      ),
    );
  }
}
