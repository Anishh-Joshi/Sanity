import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/widgets/circle_avatar.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
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
                  "Account",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: height * 0.045),
                ),
                SizedBox(
                  height: height * 0.07,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Photo",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoaded) {
                          return CircleAvatarCustom(
                            url: state.user!.profileImgUrl!,
                            radius: height * 0.08,
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    const Opacity(
                      opacity: 0,
                      child: Text(""),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoaded) {
                      return TextSettingWidget(
                          text: "Name", state: state.user!.fullName!);
                    }
                    return const SizedBox();
                  },
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Gender",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoaded) {
                          return Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: state.user!.gender == "Male"
                                            ? Colors.deepPurpleAccent
                                            : Theme.of(context).cardColor,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Icon(
                                      Icons.male,
                                      color: state.user!.gender == "Male"
                                          ? Colors.white
                                          : const Color.fromARGB(
                                              255, 99, 98, 98),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.004,
                                  ),
                                  Text(
                                    "Male",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: state.user!.gender == "Female"
                                            ? Colors.deepPurpleAccent
                                            : Theme.of(context).cardColor,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Icon(
                                      Icons.female,
                                      color: state.user!.gender == "Female"
                                          ? Colors.white
                                          : const Color.fromARGB(
                                              255, 99, 98, 98),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.004,
                                  ),
                                  Text(
                                    "Female",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: state.user!.gender != "Female" &&
                                                state.user!.gender != "Male"
                                            ? Colors.deepPurpleAccent
                                            : Theme.of(context).cardColor,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Icon(
                                      AntDesign.meh,
                                      color: state.user!.gender != "Female" &&
                                              state.user!.gender != "Male"
                                          ? Colors.white
                                          : const Color.fromARGB(
                                              255, 99, 98, 98),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.004,
                                  ),
                                  Text(
                                    "Other",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    const Opacity(
                      opacity: 0,
                      child: Text("Photo"),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoaded) {
                      return TextSettingWidget(
                          text: "Age", state: state.user!.age!.toString());
                    }
                    return const SizedBox();
                  },
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoaded) {
                      return TextSettingWidget(
                          text: "Address", state: state.user!.address!);
                    }
                    return const SizedBox();
                  },
                ),
                SizedBox(
                  height: height * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextSettingWidget extends StatelessWidget {
  final String text;
  final String state;
  const TextSettingWidget({
    Key? key,
    required this.text,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headline4,
        ),
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withAlpha(80),
              borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextFormField(
                initialValue: state,
                style: Theme.of(context).textTheme.headline4,
                decoration: InputDecoration(
                  hintText: text,
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
          ),
        ),
        // const Opacity(
        //   opacity: 0,
        //   child: Text(
        //     "",
        //   ),
        // )
      ],
    );
  }
}
