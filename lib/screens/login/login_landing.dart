import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginLanding extends StatelessWidget {
  static const String routeName = 'login_landing';
  const LoginLanding({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
        builder: (context) => const LoginLanding(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
    ));
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(child: Text("")),
              Column(
                children: [
                  const Image(
                    image: AssetImage('assets/logos/sanity_half.png'),
                  ),
                  Center(
                      child: DelayedWidget(
                    delayDuration:
                        const Duration(milliseconds: 200), // Not required
                    animationDuration:
                        const Duration(seconds: 1), // Not required
                    animation:
                        DelayedAnimations.SLIDE_FROM_BOTTOM, // Not required

                    child: Text(
                      "Sanity",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: height * 0.05),
                    ),
                  )),
                ],
              ),
              const Expanded(child: Text("")),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () {
                    Navigator.pushNamed(context, 'login');
                  },
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          "Login",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white, fontSize: 18),
                        )),
                      ))),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'signup');
                  },
                  child: Text(
                    "Don't have an account? Sign up.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 14),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Privacy Policy",
                    style: Theme.of(context).textTheme.headline6!,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
