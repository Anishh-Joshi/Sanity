import 'package:flutter/material.dart';
import 'package:sanity/widgets/login_signup_header.dart';
import '../../widgets/floatingbutton.dart';
import '../../widgets/platform_aware.dart';

class Signup extends StatelessWidget {
  static const String routeName = 'signup';
  Signup({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => Signup(),
        settings: const RouteSettings(name: routeName));
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _handleSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        Navigator.pushNamed(context, 'email_verification');
      } catch (e) {
        PlatformAADialog(
          title: 'Sign In Failed',
          content: e.toString(),
          defaultActionText: "Ok",
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: GestureDetector(
          onTap: () {
            print('pressed');
          },
          child: FloatingButon(
            callback: () {
              print("oressed");
              _handleSubmit(context);
            },
          ),
        ),
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
                        const LoginSiginUpHeader(
                          mainHeader: "Sign up",
                          subheader: "Let’s setup you profile",
                          lottepath: "assets/lottie/setup.json",
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
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 0),
                                    child: Column(children: [
                                      _buildEmailForm(
                                          context, _emailController),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      _buildPasswordForm(
                                          context, _passwordController),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      _buildConfirmPasswordForm(
                                          context,
                                          _confirmPasswordController,
                                          _passwordController)
                                    ]),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    )))));
  }
}

_buildEmailForm(
  BuildContext context,
  TextEditingController _emailController,
) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.amber,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 8, top: 2, bottom: 5),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        onChanged: (email) {},
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontSize: 15, color: const Color(0xff787878)),
        decoration: const InputDecoration(
          enabled: true,
          hintText: "Email",
          hintStyle: TextStyle(color: Colors.black),
          prefixIcon: Icon(
            Icons.mail,
            color: Colors.amber,
          ),
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null) {
            return 'Please enter some text';
          }
          if (!value.contains("@")) {
            return 'Invalid Email';
          }
          return null;
        },
      ),
    ),
  );
}

_buildPasswordForm(
    BuildContext context, TextEditingController _passwordController) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.amber,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 8, top: 2, bottom: 5),
      child: TextFormField(
        controller: _passwordController,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontSize: 15, color: const Color(0xff787878)),
        onChanged: (password) {},
        obscureText: true,
        validator: (value) {
          if (value == null) {
            return 'Please enter some text';
          }
          if (value.length < 6) {
            return 'Password too short.';
          }
          return null;
        },
        decoration: const InputDecoration(
          enabled: true,
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.amber,
          ),
        ),
      ),
    ),
  );
}

_buildConfirmPasswordForm(
  BuildContext context,
  TextEditingController _confirmPasswordController,
  TextEditingController _passswordController,
) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.amber,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 8, top: 2, bottom: 5),
      child: TextFormField(
        controller: _confirmPasswordController,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontSize: 15, color: const Color(0xff787878)),
        onChanged: (password) {},
        obscureText: true,
        validator: (value) {
          if (value == null) {
            return 'Please enter some text';
          }
          if (value.length < 6) {
            return 'Password too short.';
          }
          if (value != _passswordController.text) {
            return 'Password and confirm password did not match.';
          }
          return null;
        },
        decoration: const InputDecoration(
          enabled: true,
          hintText: "Confirm your password",
          hintStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.amber,
          ),
        ),
      ),
    ),
  );
}
