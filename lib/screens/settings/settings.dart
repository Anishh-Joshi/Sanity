import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/screens/settings/account.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import '../../blocs/theme/theme_bloc_bloc.dart';
import '../../widgets/arrow_forward_icon.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:  Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Settings",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: height * 0.045),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Text(
                  "Account",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontSize: height * 0.025),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if(state is HomeLoaded){
                      return  InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const Account()));
                        },
                        child: Row(
                        children: [
                           Expanded(
                              flex: 1,
                              child: CircleAvatarCustom(
                                url: state.user!.profileImgUrl!,
                                radius: 40,
                              )),
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.user!.fullName!,
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    Text(
                                      state.user!.gender!,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                              height: height * 0.055,
                              width: height * 0.055,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(60)),
                              child: SettingsIcon(
                                  icon: Icon(Icons.arrow_forward_ios,
                                      size: 18,
                                      color: Theme.of(context).iconTheme.color),
                                  callback: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Account()));
                                  }))
                        ],
                                          ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                Text(
                  "Settings",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontSize: height * 0.025),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                Options(
                  height: height,
                  icon: const Icon(
                    AntDesign.earth,
                    size: 20,
                    color: Colors.deepOrange,
                  ),
                  text: "Language",
                  subtext: "English",
                  callback: () {},
                  accentColor: Colors.deepOrange.withAlpha(85),
                ),
                Options(
                  height: height,
                  icon: const Icon(MaterialIcons.notifications,
                      size: 20, color: Colors.blue),
                  text: "Notifications",
                  callback: () {},
                  accentColor: Colors.blue.withAlpha(85),
                ),
                Options(
                  height: height,
                  icon: const Icon(Ionicons.moon,
                      size: 20, color: Colors.deepPurple),
                  text: "Dark Mode",
                  callback: () {},
                  accentColor: Colors.deepPurple.withAlpha(95),
                ),
                Options(
                  height: height,
                  icon: const Icon(Ionicons.help_buoy,
                      size: 20, color: Colors.pink),
                  text: "Help",
                  callback: () {},
                  accentColor: Colors.pink.withAlpha(99),
                ),
                Options(
                  height: height,
                  icon: const Icon(Ionicons.help_buoy,
                      size: 20, color: Colors.teal),
                  text: "About Sanity",
                  subtext: "1.0.0",
                  callback: () {},
                  accentColor: Colors.teal.withAlpha(99),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Options extends StatefulWidget {
  final Icon icon;
  final String text;
  final VoidCallback callback;
  final Color accentColor;
  final String subtext;
  const Options({
    Key? key,
    this.subtext = "",
    required this.height,
    required this.icon,
    required this.text,
    required this.callback,
    required this.accentColor,
  }) : super(key: key);

  final double height;

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: width * 0.06, left: 12),
      child: Row(
        children: [
          Container(
            height: height * 0.05,
            width: height * 0.05,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: widget.accentColor),
            child: widget.icon,
          ),
          Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(left: width * 0.08),
                child: Text(
                  widget.text,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontSize: 18),
                ),
              )),
          widget.text == "Dark Mode"
              ? BlocBuilder<ThemeBloc, ThemeBlocState>(
                  builder: (context, state) {
                  return Row(
                    children: [
                      Text(
                        state.isDark ? "On" : "Off",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Switch(
                        value: state.isDark,
                        onChanged: (value) {
                          context.read<ThemeBloc>().add(ChangeTheme());
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeTrackColor:
                            Theme.of(context).colorScheme.secondary,
                        activeColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  );
                })
              : Row(
                  children: [
                    Text(
                      widget.subtext,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    Container(
                        height: height * 0.055,
                        width: height * 0.055,
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(60)),
                        child: SettingsIcon(
                            icon: Icon(Icons.arrow_forward_ios,
                                size: 18,
                                color: Theme.of(context).iconTheme.color),
                            callback: widget.callback)),
                  ],
                )
        ],
      ),
    );
  }
}
