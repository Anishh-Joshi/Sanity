import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/widgets/circle_avatar.dart';

const _maxHeaderExtent = 60.0;
const _minHeaderExtent = 0.0;
const _maxImageSize = 25;
const _minImageSize = 0.0;
const _maxTextSize = 22;
const _minTextSize = 0.0;
const _maxTextSizeName = 15;
const _minTextSizeName = 0.0;

class MyHomeGreetHeader extends SliverPersistentHeaderDelegate {
  final GlobalKey<ScaffoldState> scaffoldKey;

  MyHomeGreetHeader({required this.scaffoldKey});
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
    final currentImageSize =
        (_maxImageSize * (1 - percent)).clamp(_minImageSize, _maxImageSize);
    final currentTextSize =
        (_maxTextSize * (1 - percent)).clamp(_minTextSize, _maxTextSize);
    final currentTextSizeName = (_maxTextSizeName * (1 - percent))
        .clamp(_minTextSizeName, _maxTextSizeName);
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
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
