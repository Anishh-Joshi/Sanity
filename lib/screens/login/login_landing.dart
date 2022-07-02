import 'package:flutter/material.dart';
import 'package:sanity/widgets/login_bubbles.dart';

class LoginLanding extends StatelessWidget {
  static const String routeName = 'login_landing';
  const LoginLanding({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const LoginLanding(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Opacity(
                  opacity: 0,
                  child: SizedBox(
                    child: Text("Logo Here"),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Image.asset('assets/logos/sanity_full.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.teal,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    )),
                                onPressed: () {},
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  child: Center(
                                    child: Text("Login",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(color: Colors.white)),
                                  ),
                                )),
                            const SizedBox(
                              height: 8,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    )),
                                onPressed: () {},
                                child: SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: Center(
                                    child: Text("Google",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Don't have an account? Sign up",
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Privacy Policy",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          LoginBubble(),
        ],
      ),
    );
  }
}
