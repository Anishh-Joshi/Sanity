import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


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
    final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
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
                
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Sign up",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(fontSize: 40)),
                        Text("Let’s setup you profile!",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontSize: 20)),
                      ]),
                  Lottie.asset('assets/lottie/swing.json',
                      height: MediaQuery.of(context).size.height / 8),
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
                            _buildEmailForm(context),
                            const SizedBox(
                              height: 4,
                            ),
                            _buildPasswordForm(context,_passwordController,"Password"),
                             const SizedBox(
                              height: 4,
                            ),
                            _buildPasswordForm(context,_confirmPasswordController,"Confirm Password"),
                          ]),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

_buildEmailForm(BuildContext context) {
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
      padding: const EdgeInsets.only(left: 0.0, right: 8, top: 5, bottom: 5),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
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
            return 'Email must contain @';
          }
          return null;
        },
      ),
    ),
  );
}

_buildPasswordForm(BuildContext context,TextEditingController controller,String customText) {
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
      padding: const EdgeInsets.only(left: 0.0, right: 8, top: 5, bottom: 5),
      child: TextFormField(
        controller: controller,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontSize: 15, color: const Color(0xff787878)),
        onChanged: (password) {},
        obscureText: true,
        decoration: const InputDecoration(
          enabled: true,
          hintText: "customText",
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
