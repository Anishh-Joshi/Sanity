import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sanity/config/app_colors.dart';

class LoginInformation extends StatefulWidget {
  static const String routeName = 'loginInfo';
  const LoginInformation({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const LoginInformation(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  State<LoginInformation> createState() => _LoginInformationState();
}

class _LoginInformationState extends State<LoginInformation> {
  int index = 0;

  List infoData = [
    {
      "screen": 1,
      "lottePath": "assets/lottie/thoughts.json",
      "text": "Hey there! Welcome to Sanity!",
      "bottom_text": "Let's Get Started",
      "repeat": false
    },
    {
      "screen": 2,
      "lottePath": "assets/lottie/meditation.json",
      "text":
          "With sanity, you can write about how you feel and you can instantly get more insights about your thoughts",
      "bottom_text": "We Are Almost done",
      "repeat": true,
    },
    {
      "screen": 3,
      "lottePath": "assets/lottie/searchDoctor.json",
      "text":
          "Did you know, you can choose the best therapist for you here at sanity!!",
      "bottom_text": "Login/Register",
      "repeat": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.teal,
                    Color.fromARGB(255, 1, 65, 59),
                  ],
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(500))),
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width / 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0, left: 15),
              child: Text(
                "Welcome!",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Colors.white, fontSize: 40),
              ),
            ),
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height / 6,
              left: MediaQuery.of(context).size.width / 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Find Your",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Color.fromARGB(255, 144, 142, 142)),
                  ),
                  Text(
                    "Sanity!",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Colors.teal,
                        fontSize: MediaQuery.of(context).size.height / 12),
                  ),
                ],
              )),
          Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.circle,
                              color: Colors.teal,
                              size: 15,
                            ),
                            Icon(
                              Icons.circle,
                              color: Color.fromARGB(255, 239, 238, 238),
                              size: 15,
                            ),
                            Icon(
                              Icons.circle,
                              color: Color.fromARGB(255, 239, 238, 238),
                              size: 15,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){},
                            child: Container(
                              height: MediaQuery.of(context).size.height / 12,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.teal,
                                      Color.fromARGB(255, 1, 65, 59),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ]),
                ),
              ))
        ],
      ),
    );
  }
}
