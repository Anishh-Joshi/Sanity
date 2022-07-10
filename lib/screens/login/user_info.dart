import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/user_info_bloc/user_info_bloc.dart';
import 'package:sanity/widgets/Login_signup_header.dart';
import 'package:sanity/widgets/custom_forms.dart';
import '../../widgets/FloatingButton.dart';

class UserInfo extends StatelessWidget {
  static const String routeName = 'user_info';
  const UserInfo({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const UserInfo(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: BlocBuilder<UserInfoBloc, UserInfoState>(
        builder: (context, state) {
          if (state is UserInfoLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UserInfoLoaded) {
            return FloatingButon(callback: () {
              context.read<UserInfoBloc>().add(SignUpPressed());
            });
          } else {
            return const Center(
              child: Text("Something Went Wrong"),
            );
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {
              if (state is UserInfoLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is UserInfoLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const LoginSiginUpHeader(
                      mainHeader: "Almost there..",
                      subheader: "A little touch up.",
                      lottepath: 'assets/lottie/profile-setup.json',
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Stack(children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xff787878)),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.amber),
                              child: const Icon(Icons.edit,
                                  size: 25, color: Colors.white))),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: Column(children: [
                        CustomTextFormField(
                          hintText: "Full Name",
                          onChanged: (val) {
                            context.read<UserInfoBloc>().add(UpdateUserInfo(
                                  fullName: val,
                                ));
                          },
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomTextFormFieldInteger(
                            hintText: "Age",
                            onChanged: (val) {
                              context.read<UserInfoBloc>().add(UpdateUserInfo(
                                    age: int.parse(val),
                                  ));
                            },
                          ),
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: CustomDropDown()),
                        CustomTextFormField(
                          hintText: "Address",
                          onChanged: (val) {
                            context.read<UserInfoBloc>().add(UpdateUserInfo(
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
                );
              } else {
                return const Center(
                  child: Text("Something Went Wrong"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
