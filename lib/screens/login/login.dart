import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import 'package:sanity/widgets/floatingbutton.dart';
import '../../widgets/platform_aware.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login';
  LoginScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
        builder: (context) => LoginScreen(),
        settings: const RouteSettings(name: routeName));
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is LoginLoading) {
          return CircularProgressIndicator(
              color: Theme.of(context).primaryColor);
        } else {
          return FloatingButon(callback: () {
            if (_formKey.currentState!.validate()) {
              context.read<LoginBloc>().add(LoginButtonPressed(
                  email: _emailController.value.text.toLowerCase().trim(),
                  password:
                      _passwordController.value.text.toLowerCase().trim()));
            }
          });
        }
      }),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            PlatformAADialog(
              title: 'Sign In Failed',
              content: state.msg,
              defaultActionText: "Ok",
            ).show(context);
          } if (state is LoginAuthenticated) {
            Navigator.pushNamedAndRemoveUntil(
                context,'home_landing', (route) => false,arguments: state.user);
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hey,",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(fontSize: 40)),
                              Text("Welcome Back!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(fontSize: 20)),
                            ]),
                        Expanded(
                          child: Lottie.asset('assets/lottie/swing.json',
                              height: MediaQuery.of(context).size.height / 6),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, bottom: 0),
                                child: Column(children: [
                                  _buildEmailForm(context, _emailController),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  _buildPasswordForm(
                                      context, _passwordController),
                                ]),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Opacity(opacity: 1, child: Text("")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, 'forgot_password');
                                    },
                                    child: Text(
                                      "Forgot your password ?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: const Color(0xff787878),
                                              fontSize: 13),
                                    )),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

_buildEmailForm(BuildContext context, TextEditingController controller) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Theme.of(context).primaryColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 8, top: 0, bottom: 5),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (email) {},
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontSize: 15, color: Theme.of(context).canvasColor),
        controller: controller,
        decoration: InputDecoration(
          enabled: true,
          hintText: "Email",
          hintStyle: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 15, color: Theme.of(context).canvasColor),
          prefixIcon: Icon(
            Icons.mail,
            color: Theme.of(context).primaryColor,
          ),
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Email cannot be blank';
          }
          if (value.length > 1 && !value.contains("@")) {
            return 'Email format invalid!';
          }
          return null;
        },
      ),
    ),
  );
}

_buildPasswordForm(BuildContext context, TextEditingController controller) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Theme.of(context).primaryColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 8, top: 0, bottom: 5),
      child: TextFormField(
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontSize: 15, color: Theme.of(context).canvasColor),
        onChanged: (password) {},
        obscureText: true,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Password cannot be blank';
          }
          if (value.length < 6) {
            return 'Password too short';
          }
          return null;
        },
        decoration: InputDecoration(
          enabled: true,
          hintText: "Passsword",
          hintStyle: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 15, color: Theme.of(context).canvasColor),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.lock,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    ),
  );
}
