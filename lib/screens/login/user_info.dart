import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/user_info_bloc/user_info_bloc.dart';
import 'package:sanity/widgets/Login_signup_header.dart';
import 'package:sanity/widgets/custom_forms.dart';
import 'package:sanity/widgets/popup_image_picker.dart';
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
                return Stack(alignment: Alignment.bottomCenter, children: [
                  Padding(
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Image(
                            image: AssetImage('assets/images/default.png'),
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: const Color(0xff787878)),
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
                  ),
                  const Positioned(child: ImagePickPopUp()),
                ]);
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
