import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:sanity/widgets/custom_drawer.dart';
import 'package:sanity/widgets/custom_thread_card.dart';
import 'package:sanity/widgets/home_card.dart';

import '../../widgets/platform_aware.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
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
                Navigator.pushNamedAndRemoveUntil(
                    context, 'landing_page', (route) => false);
              }
            },
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: _MyHomeGreetHeader(scaffoldKey: _scaffoldKey)),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const HomeSymmaryCard(),
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
                )
              ],
            ),
          )),
        ),
        drawer: const CustomDrawer());
  }
}

const _maxHeaderExtent = 60.0;
const _minHeaderExtent = 0.0;
const _maxImageSize = 25;
const _minImageSize = 0.0;
const _maxTextSize = 22;
const _minTextSize = 0.0;
const _maxTextSizeName = 15;
const _minTextSizeName = 0.0;

class _MyHomeGreetHeader extends SliverPersistentHeaderDelegate {
  final GlobalKey<ScaffoldState> scaffoldKey;

  _MyHomeGreetHeader({required this.scaffoldKey});
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

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / _maxHeaderExtent;
    final size = MediaQuery.of(context).size;
    final currentImageSize =
        (_maxImageSize * (1 - percent)).clamp(_minImageSize, _maxImageSize);
    final currentTextSize =
        (_maxTextSize * (1 - percent)).clamp(_minTextSize, _maxTextSize);
    final currentTextSizeName = (_maxTextSizeName * (1 - percent))
        .clamp(_minTextSizeName, _maxTextSizeName);
    return Container(
      color: Theme.of(context).canvasColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoaded) {
                  return GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    child: CircleAvatarCustom(
                        radius: currentImageSize.toDouble(),
                        url: state.user!.profileImgUrl!),
                  );
                }
                return const CircleAvatar();
              },
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "${greetingMessage()},",
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontSize: currentTextSize.toDouble()),
            ),
            BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state is HomeLoaded) {
                return Text("${state.user!.fullName}",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontSize: currentTextSizeName.toDouble()));
              }
              return const Text("Something Went Wrong");
            }),
          ]),
        ],
      ),
    );
  }

  @override
  double get maxExtent => _maxHeaderExtent;

  @override
  double get minExtent => _minHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
