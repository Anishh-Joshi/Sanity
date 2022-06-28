import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login';
  LoginScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => LoginScreen(),
        settings: const RouteSettings(name: routeName));
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 248, 248),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                child: Image(
                  image: AssetImage('assets/logos/sanity_full.png'),
                ),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                          child: Column(children: [
                            _buildEmailForm(),
                            const SizedBox(
                              height: 4,
                            ),
                            _buildPasswordForm(),
                          ]),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Opacity(opacity: 1, child: Text("")),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot your password ?",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        color: Colors.black, fontSize: 15),
                              )),
                        ],
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.amber,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () {},
                          child: const SizedBox(
                              width: double.infinity,
                              child: Center(child: Text("Login")))),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () {},
                          child: SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Icon(
                                    AntDesign.google,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    "Sign in with Google",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Opacity(
                                      opacity: 1,
                                      child: Icon(AntDesign.google)),
                                ],
                              ))),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Don't have an account? Sign up.",
                            style: TextStyle(color: Colors.black),
                          )),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

_buildEmailForm() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (email) {},
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          enabled: true,
          hintText: "Email",
          hintStyle: TextStyle(color: Colors.black),
          prefixIcon: Icon(
            Icons.mail,
            color: Colors.amber,
          ),
          border: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
          ),
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

_buildPasswordForm() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        onChanged: (password) {},
        obscureText: true,
        decoration: const InputDecoration(
          enabled: true,
          hintText: "Passsword",
          hintStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.amber,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
          ),
        ),
      ),
    ),
  );
}
