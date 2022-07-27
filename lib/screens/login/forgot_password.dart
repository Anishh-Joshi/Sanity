import 'package:flutter/material.dart';

import '../../widgets/platform_aware.dart';

class ForgotPassword extends StatelessWidget {
  static const String routeName = 'forgot_password';
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => ForgotPassword(),
        settings: const RouteSettings(name: routeName));
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

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
        body: SafeArea(
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hey,",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(fontSize: 35)),
                        Text("Don't worry we got your back!",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontSize: 20)),
                      ]),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 12,
            ),
            Form(
                key: _formKey,
                child: Container(
                  child: _buildEmailForm(context, _emailController),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Center(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 39, 39, 39),
                        spreadRadius: 0,
                        blurRadius: 6,
                        offset: Offset(
                          2,
                          5,
                        ),
                      )
                    ]),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () {
                    _handleSubmit(context);
                  },
                  child: Center(
                    child: Text(
                      "Send Reset Link",
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

_buildEmailForm(
  BuildContext context,
  TextEditingController _emailController,
) {
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
        controller: _emailController,
        onChanged: (email) {},
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontSize: 15, color: const Color(0xff787878)),
        decoration: InputDecoration(
          enabled: true,
          hintText: "Email",
          hintStyle: const TextStyle(color: Colors.black),
          prefixIcon: Icon(
            Icons.mail,
            color: Theme.of(context).primaryColor,
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
