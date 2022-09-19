import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/blocs/theme/theme_bloc_bloc.dart';
import 'package:sanity/screens/settings/settings.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:sanity/widgets/custom_elevated_button.dart';
import 'package:sanity/widgets/platform_aware.dart';
import '../blocs/login/login_bloc.dart';

class CustomDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CustomDrawer({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        child: SafeArea(
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginError) {
                const PlatformAADialog(
                  title: 'Sign up Failed',
                  content: "Something went wrong!",
                  defaultActionText: "Ok",
                ).show(context);
              } else if (state is LoginUnAuthenticated) {
                Navigator.of(context,rootNavigator:true ).pushNamedAndRemoveUntil('landing_page', (route) => false);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 10, bottom: 10),
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(),
                        child: BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is HomeLoaded) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      widget.scaffoldKey.currentState
                                          ?.closeDrawer();
                                           Navigator.of(context, rootNavigator: true).pushNamed("profile_page");
                                     
                                    },
                                    child: CircleAvatarCustom(
                                        radius:
                                            MediaQuery.of(context).size.height /
                                                25,
                                        url: state.user!.profileImgUrl!),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(state.user!.fullName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3),
                                ],
                              );
                            }
                            return const Text("");
                          },
                        ),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      onTap: (){},
                      leading: Icon(
                        Entypo.line_graph,
                        color: Theme.of(context).indicatorColor,
                      ),
                      title: Text(
                        'Progress Report',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Settings()));
                      },
                      leading: Icon(
                        Ionicons.settings_outline,
                        color: Theme.of(context).indicatorColor,
                      ),
                      title: Text(
                        'Settings',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    ListTile(
                        title: Text(
                          "Dark Mode",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        trailing: BlocBuilder<ThemeBloc, ThemeBlocState>(
                            builder: (context, state) {
                          return Switch(
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
                          );
                        }),
                        leading: Icon(
                          MaterialCommunityIcons.theme_light_dark,
                          color: Theme.of(context).indicatorColor,
                        )),
                    ListTile(
                      leading: Icon(
                        Ionicons.ios_document_text_outline,
                        color: Theme.of(context).indicatorColor,
                      ),
                      title: Text(
                        'Privacy Policy',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Entypo.documents,
                        color: Theme.of(context).indicatorColor,
                      ),
                      title: Text(
                        'About us',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 80),
                        child: BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            if (state is LoginAuthenticated) {
                              return ElevatedButtonCustom(
                                color: Color.fromARGB(255, 233, 11, 104),
                                buttonTitle: "Logout",
                                action: () {
                                  context
                                      .read<LoginBloc>()
                                      .add(LogoutButtonPressed());
                                },
                                icon: MaterialCommunityIcons.power,
                              );
                            }
                            return const Text("");
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
