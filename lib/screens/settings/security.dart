import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/blocs/user_info_bloc/user_info_bloc.dart';
import 'package:sanity/widgets/custom_form.dart';
import 'package:sanity/widgets/filead_header.dart';

import '../../widgets/platform_aware.dart';

class Security extends StatefulWidget {
  static const String routeName = 'security';
  const Security({Key? key}) : super(key: key);
  static Route route(RouteSettings setting) {
    return MaterialPageRoute(
        builder: (context) => const Security(), settings: setting);
  }

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  void dispose(){
    _confirmPassword.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(ChangePassword(
                        email: state.baseUser!.email!,
                        password: _password.text,
                        confirmPassword: _confirmPassword.text));
                  }
                },
                child: const Icon(Icons.arrow_forward));
          }
          return const SizedBox();
        },
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Password Changed Successfully")));
                _confirmPassword.clear();
                _password.clear();
                Navigator.pop(context);
          }
          if (state is LoginError) {
            const PlatformAADialog(
              title: "Failed",
              content: "Something went wrong!",
              defaultActionText: 'Ok',
            ).show(context);
          }
        },
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoaded) {
                      return AppBarInfo(
                          height: height,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginBloc>().add(ChangePassword(
                                  email: state.baseUser!.email!,
                                  password: _password.text,
                                  confirmPassword: _confirmPassword.text));
                            }
                          },
                          showDone: true,
                          title: "Security");
                    }
                    return const SizedBox();
                  },
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(14)),
                    width: double.infinity,
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoaded) {
                          return CustomForm(
                            enabled: false,
                            iconData: Icons.email,
                            iconColor: Theme.of(context).primaryColor,
                            validator: (value) {},
                            initialValue: state.baseUser!.email,
                            borderColor: Colors.transparent,
                            borderRadius: 14,
                            onChanged: (val) {},
                          );
                        }
                        return const SizedBox();
                      },
                    )),
                const Divider(
                  color: Colors.transparent,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(14)),
                    width: double.infinity,
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoaded) {
                          return CustomForm(
                            controller: _password,
                            hintText: "New Password",
                            obscureText: true,
                            iconData: Icons.lock,
                            iconColor: Theme.of(context).primaryColor,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password cannot be blank';
                              }
                              if (value.length < 6) {
                                return 'Password too short';
                              }
                              if (value != _confirmPassword.text) {
                                return "Password doesn't match";
                              }
                              return null;
                            },
                            borderColor: Colors.transparent,
                            borderRadius: 14,
                            onChanged: (val) {},
                          );
                        }
                        return const SizedBox();
                      },
                    )),
                const Divider(
                  color: Colors.transparent,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(14)),
                    width: double.infinity,
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoaded) {
                          return CustomForm(
                            controller: _confirmPassword,
                            hintText: "Confirm New Password",
                            iconData: Icons.lock,
                            obscureText: true,
                            iconColor: Theme.of(context).primaryColor,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Confirm password cannot be blank';
                              }
                              if (value.length < 6) {
                                return 'Confirm password too short';
                              }
                              if (value != _password.text) {
                                return "Password doesn't match";
                              }
                              return null;
                            },
                            borderColor: Colors.transparent,
                            borderRadius: 14,
                            onChanged: (value) {},
                          );
                        }
                        return const SizedBox();
                      },
                    )),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
