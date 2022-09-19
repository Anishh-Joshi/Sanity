import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/blocs/user_info_bloc/user_info_bloc.dart';
import 'package:sanity/widgets/custom_forms.dart';
import 'package:sanity/widgets/floatingbutton.dart';
import 'package:sanity/widgets/login_signup_header.dart';
import 'package:sanity/widgets/popup_image_picker.dart';


class UserInfo extends StatefulWidget {
  static const String routeName = 'user_info';
  const UserInfo({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
        builder: (context) => const UserInfo(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final TextEditingController _nmcIdController = TextEditingController();
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.amberAccent;
    }
    return Theme.of(context).primaryColor;
  }

  final ScrollController _scrollController = ScrollController();
  bool isPopUpOpen = false;

  void handlePopUp() {
    setState(() {
      isPopUpOpen = !isPopUpOpen;
      _scrollController.animateTo(
        isPopUpOpen ? 100 : -100,
        duration: const Duration(seconds: 1),
        curve: Curves.ease,
      );
    });
  }

  bool isChecked = false;
  Future<ImageProvider<Object>> xFileToImage(XFile xFile) async {
    final Uint8List bytes = await xFile.readAsBytes();
    return Image.memory(bytes).image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isPopUpOpen
          ? null
          : BlocBuilder<UserInfoBloc, UserInfoState>(
              builder: (context, state) {
                if (state is UserInfoLoaded) {
                  return BlocBuilder<LoginBloc, LoginState>(builder: (ctx, st) {
                    if (st is LoginEmailNotVerified) {
                      int id = st.id;
                      return FloatingButon(callback: () {
                        if (state.userInfoModel.fullName == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Name field can't be empty!")));
                        } else if (state.userInfoModel.age == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Age field can't be empty!")));
                        } else if (state.userInfoModel.address == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Address field can't be empty!")));
                        } else if (state.userInfoModel.isDoctor! &&
                            state.userInfoModel.nmcId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("You must provide your Nmc Id!")));
                        } else {
                          context.read<UserInfoBloc>().add(SignUpPressed(
                              userInfo: state.userInfoModel, id: id));
                        }
                      });
                    }
                    if (st is UnRegisteredUser) {
                      return FloatingButon(callback: () {
                        if (state.userInfoModel.fullName == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Name field can't be empty!")));
                        } else if (state.userInfoModel.age == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Age field can't be empty!")));
                        } else if (state.userInfoModel.address == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Address field can't be empty!")));
                        } else if (state.userInfoModel.isDoctor != null &&
                            state.userInfoModel.nmcId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("You must provide your Nmc Id!")));
                        } else {
                          context.read<UserInfoBloc>().add(SignUpPressed(
                              userInfo: state.userInfoModel, id: st.id));
                        }
                      });
                    }
                    return FloatingButon(callback: () {});
                  });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
      body: BlocListener<UserInfoBloc, UserInfoState>(
        listener: (context, state) {
          if (state is SignupFormFilled) {
            context.read<LoginBloc>().add(LoginCheck());
            Navigator.pushNamedAndRemoveUntil(
                context, 'landing_page', (route) => false);
            context.read<UserInfoBloc>().add(SignUpLoading());
          }
        },
        child: GestureDetector(
          onTap: () {
            setState(() {
              isPopUpOpen = false;
            });
          },
          child: BlocListener<UserInfoBloc, UserInfoState>(
            listener: (context, state) {
              if (state is UserInfoError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.msg)));
              }
            },
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      BlocBuilder<UserInfoBloc, UserInfoState>(
                        builder: (context, state) {
                          if (state is UserInfoLoading) {
                            return const CircularProgressIndicator();
                          }

                          if (state is UserInfoLoaded) {
                            return Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const LoginSiginUpHeader(
                                        mainHeader: "Almost there..",
                                        subheader: "A little touch up.",
                                        lottepath:
                                            'assets/lottie/profile-setup.json',
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Stack(children: [
                                        state.profileImage == null
                                            ? const Image(
                                                image: AssetImage(
                                                    'assets/images/default.png'),
                                                height: 150,
                                                width: 150,
                                                fit: BoxFit.cover,
                                              )
                                            : CircleAvatar(
                                                radius: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    12,
                                                backgroundImage: FileImage(
                                                    state.profileImage!)),
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
                                                          BorderRadius.circular(
                                                              50),
                                                      color: const Color(
                                                          0xff787878)),
                                                  child: const Icon(Icons.edit,
                                                      size: 25,
                                                      color: Colors.white)),
                                            )),
                                      ]),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomTextFormField(
                                                hintText: "Full Name",
                                                onChanged: (val) {
                                                  context
                                                      .read<UserInfoBloc>()
                                                      .add(UpdateUserInfo(
                                                          fullName: val));
                                                },
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child:
                                                    CustomTextFormFieldInteger(
                                                  hintText: "Age",
                                                  onChanged: (val) {
                                                    context
                                                        .read<UserInfoBloc>()
                                                        .add(UpdateUserInfo(
                                                          age: int.parse(val),
                                                        ));
                                                  },
                                                ),
                                              ),
                                              const CustomDropDown(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Are you a doctor?",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                             
                                                              fontSize: 16),
                                                    ),
                                                    Checkbox(
                                                        checkColor:
                                                            Theme.of(context).colorScheme.secondary,
                                                        fillColor:
                                                            MaterialStateProperty
                                                                .resolveWith(
                                                                    getColor),
                                                        value: isChecked,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            isChecked = val!;
                                                          });
                                                          context
                                                              .read<
                                                                  UserInfoBloc>()
                                                              .add(UpdateUserInfo(
                                                                  isDoctor:
                                                                      isChecked));
                                                        }),
                                                  ],
                                                ),
                                              ),
                                              isChecked
                                                  ? CustomTextFormFieldInteger(
                                                      hintText: 'Nmc Id',
                                                      controller:
                                                          _nmcIdController,
                                                      onChanged: (val) {
                                                        context
                                                            .read<
                                                                UserInfoBloc>()
                                                            .add(UpdateUserInfo(
                                                                nmcId:
                                                                    int.parse(
                                                                        val)));
                                                      },
                                                    )
                                                  : const SizedBox(
                                                      height: 0,
                                                    ),
                                              CustomTextFormField(
                                                hintText: "Address",
                                                onChanged: (val) {
                                                  context
                                                      .read<UserInfoBloc>()
                                                      .add(UpdateUserInfo(
                                                        address: val,
                                                      ));
                                                },
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ]),
                                      )
                                    ]),
                                  ),
                                ]);
                          } else {
                            return const Center(
                              child:
                                  Text("Something went wrong inside userinfo"),
                            );
                          }
                        },
                      ),
                      isPopUpOpen
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPopUpOpen = false;
                                });
                              },
                              child: const ImagePickPopUp())
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
