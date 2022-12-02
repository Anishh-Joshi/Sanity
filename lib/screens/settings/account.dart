import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/model/user_class.dart';
import 'package:sanity/model/user_info_model.dart';
import 'package:sanity/repository/auth_repo.dart';
import 'package:sanity/repository/signup/signup_repo.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:sanity/widgets/filead_header.dart';
import '../../blocs/user_info_bloc/user_info_bloc.dart';
import '../../widgets/popup_image_picker.dart';

class Account extends StatefulWidget {
  final UserInfoModel user;
  final User userBase;
  const Account({required this.userBase, required this.user, Key? key})
      : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  UserInfoModel? doc;
  final SignUpRepository up = SignUpRepository();
  Map? arg;
  final AuthRepository auth = AuthRepository();
  Future<void> update(UserInfoModel userInfoData) async {
    final int response = await up.updateUserInfo(userInfoData,
        id: widget.userBase.id!, profileId: widget.user.userId!);

    context.read<LoginBloc>().add(LoginCheck());

    if (response == 404) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong!")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account Edited Successfully")));
    }
  }

  bool isPopUpOpen = false;
  bool showImagePicker = false;

  void handlePopUp() {
    setState(() {
      if (isPopUpOpen) {
        showImagePicker = false;
      }
      isPopUpOpen = !isPopUpOpen;
    });

    Timer(Duration(milliseconds: !showImagePicker ? 200 : 0), () {
      setState(() {
        showImagePicker = isPopUpOpen;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<UserInfoBloc, UserInfoState>(
                    builder: (context, state) {
                      if (state is UserInfoLoaded) {
                        return AppBarInfo(
                            showDone: true,
                            height: height,
                            onPressed: () async {
                              await update(state.userInfoModel);

                              context.read<HomeBloc>().add(UpdateHomeInfo());
                            },
                            title: "Account");
                      }
                      return const SizedBox();
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Photo",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoaded) {
                            return BlocBuilder<UserInfoBloc, UserInfoState>(
                              builder: (context, st) {
                                if (st is UserInfoLoaded) {
                                  return Stack(children: [
                                    st.profileImage != null
                                        ? CircleAvatar(
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            backgroundImage:
                                                FileImage(st.profileImage!))
                                        : CircleAvatarCustom(
                                            url: state.user!.profileImgUrl!,
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10),
                                    Positioned(
                                        bottom: 5,
                                        right: 5,
                                        child: GestureDetector(
                                          onTap: handlePopUp,
                                          child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              child: const Icon(Icons.edit,
                                                  size: 25,
                                                  color: Colors.white)),
                                        )),
                                  ]);
                                }
                                return const SizedBox();
                              },
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
                            text: "Name",
                            onchanged: (val) {
                              context
                                  .read<UserInfoBloc>()
                                  .add(UpdateUserInfo(fullName: val));
                            },
                            state: state.user!.fullName!);
                      }
                      return const SizedBox();
                    },
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  BlocBuilder<UserInfoBloc, UserInfoState>(
                    builder: (context, state) {
                      if (state is UserInfoLoaded) {
                        return BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, st) {
                            if (st is HomeLoaded) {
                              return GenderBox(
                                  isAccountView: true,
                                  gender: state.userInfoModel.gender ??
                                      st.user!.gender!,
                                  height: height);
                            }
                            return SizedBox();
                          },
                        );
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
                            onchanged: (val) {
                              context
                                  .read<UserInfoBloc>()
                                  .add(UpdateUserInfo(age: int.parse(val)));
                            },
                            text: "Age",
                            state: state.user!.age!.toString());
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
                            onchanged: (val) {
                              context
                                  .read<UserInfoBloc>()
                                  .add(UpdateUserInfo(address: val));
                            },
                            text: "Address",
                            state: state.user!.address!);
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
                            onchanged: (val) {
                              context
                                  .read<UserInfoBloc>()
                                  .add(UpdateUserInfo(bio: val));
                            },
                            text: "About You",
                            state: state.user!.bio == null
                                ? ""
                                : state.user!.bio!);
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
          isPopUpOpen
              ? GestureDetector(
                  onTap: () {
                    handlePopUp();
                  },
                  child: Opacity(
                    opacity: 0.2,
                    child: Container(
                      color: Colors.black,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                  ))
              : const SizedBox(),
          Positioned(
            bottom: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              height:
                  isPopUpOpen ? MediaQuery.of(context).size.height * 0.20 : 0,
              width: MediaQuery.of(context).size.width,
              child: showImagePicker ? const ImagePickPopUp() : null,
            ),
          ),
        ]),
      ),
    );
  }
}

class GenderBox extends StatelessWidget {
  final String gender;
  final bool isAccountView;
  const GenderBox({
    Key? key,
    required this.isAccountView,
    required this.height,
    required this.gender,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Gender",
          style: Theme.of(context).textTheme.headline4,
        ),
        Row(
          children: [
            Column(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: gender == "Male"
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: IconButton(
                    onPressed: () {
                      if (isAccountView) {
                        context
                            .read<UserInfoBloc>()
                            .add(UpdateUserInfo(gender: 'Male'));
                      }
                    },
                    icon: Icon(
                      Icons.male,
                      color: gender == "Male"
                          ? Colors.white
                          : const Color.fromARGB(255, 99, 98, 98),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.004,
                ),
                Text(
                  "Male",
                  style: Theme.of(context).textTheme.headline6,
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
                      color: gender == "Female"
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: IconButton(
                    onPressed: () {
                      if (isAccountView) {
                        context
                            .read<UserInfoBloc>()
                            .add(UpdateUserInfo(gender: 'Female'));
                      }
                    },
                    icon: Icon(
                      Icons.female,
                      color: gender == "Female"
                          ? Colors.white
                          : const Color.fromARGB(255, 99, 98, 98),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.004,
                ),
                Text(
                  "Female",
                  style: Theme.of(context).textTheme.headline6,
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
                      color: gender != "Female" && gender != "Male"
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: IconButton(
                    onPressed: () {
                      if (isAccountView) {
                        context
                            .read<UserInfoBloc>()
                            .add(UpdateUserInfo(gender: 'Other'));
                      }
                    },
                    icon: Icon(
                      AntDesign.meh,
                      color: gender != "Female" && gender != "Male"
                          ? Colors.white
                          : const Color.fromARGB(255, 99, 98, 98),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.004,
                ),
                Text(
                  "Other",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ],
        ),
        const Opacity(
          opacity: 0,
          child: Text("Photo"),
        )
      ],
    );
  }
}

class TextSettingWidget extends StatelessWidget {
  final String text;
  final String state;
  final Function(String)? onchanged;
  final bool enable;
  const TextSettingWidget({
    Key? key,
    this.enable = true,
    required this.text,
    this.onchanged,
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
                onChanged: onchanged,
                style: Theme.of(context).textTheme.headline4,
                decoration: InputDecoration(
                  enabled: enable,
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
