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
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: index == 2
              ? null
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 2;
                    });
                  },
                  child: Text(
                    "Skip ",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Color.fromARGB(255, 216, 218, 216)),
                  ),
                ),
          actions: index == 2
              ? null
              : [
                  GestureDetector(
                    onTap: () {
                      if (index < 2) {
                        setState(() {
                          index++;
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          "Next",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: AppColors.textColor()),
                        ),
                        IconButton(
                            onPressed: () {
                              if (index < 2) {
                                setState(() {
                                  index++;
                                });
                              } else {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    'login', (Route<dynamic> route) => false);
                              }
                            },
                            icon: Icon(
                              Icons.arrow_forward,
                              color: AppColors.textColor(),
                            )),
                      ],
                    ),
                  )
                ],
        ),
        backgroundColor: Colors.white,
        body: index == 2
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Lottie.asset(infoData[index]['lottePath']),
                    Text(
                      infoData[index]['text'],
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: AppColors.textColor()),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.textColor(),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'login', (route) => false);
                        },
                        child: SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text("Login/Register",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(color: Colors.white)),
                            ))),
                  ],
                ),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 2.2,
                      child: Row(children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Text(infoData[index]['text'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      fontSize: index == 0 ? 40 : 28,
                                      color: AppColors.textColor())),
                        ),
                        const Expanded(
                          child: Center(
                            child: Image(
                              image:
                                  AssetImage('assets/logos/sanity_intro.png'),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Lottie.asset(infoData[index]['lottePath'],
                          width: double.infinity, fit: BoxFit.cover),
                    ),
                  )
                ],
              ));
  }
}
