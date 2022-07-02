import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sanity/screens/login/login_landing.dart';

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
      "lottePath": "assets/lottie/welcome.json",
      "text": "Hey there!\nWelcome to Sanity.",
      "bottom_text":
          "Congratulations on taking your first step towards sanity. We are here to help.",
      "repeat": false
    },
    {
      "screen": 2,
      "lottePath": "assets/lottie/girl_stydy.json",
      "text": "Did you know ?",
      "bottom_text":
          "You can join many other people like you here in sanity? You can text them any time,and have a meaningful conversation.",
      "repeat": true,
    },
    {
      "screen": 3,
      "lottePath": "assets/lottie/girl_stydy.json",
      "text": "Did you know ?",
      "bottom_text":
          "Sanity process your feelings with Machine learning and gives a detailed insights about your feelings. Also,in severe cases it  automatically suggests nearby therapisyt/doctors",
      "repeat": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Column(
                children: [
                  Container(
                    child: Lottie.asset(infoData[index]['lottePath']),
                  ),
                  Text(
                    infoData[index]['text'],
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: 24),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10,
                        left: MediaQuery.of(context).size.width / 7,
                        right: MediaQuery.of(context).size.width / 7),
                    child: Text(
                      infoData[index]['bottom_text'],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: const Color(0xff787878), fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.circle,
                      size: 20,
                      color:
                          index == 0 ? Colors.amber : const Color(0xffD9D9D9)),
                  Icon(Icons.circle,
                      size: 20,
                      color:
                          index == 1 ? Colors.amber : const Color(0xffD9D9D9)),
                  Icon(Icons.circle,
                      size: 20,
                      color:
                          index == 2 ? Colors.amber : const Color(0xffD9D9D9)),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'login', (route) => false);
              },
              child: Text(
                "Skip",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: const Color(0xff787878), fontSize: 20),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (index < 2) {
                  setState(() {
                    index++;
                  });
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'login', (route) => false);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(50)),
                height: 70,
                width: 70,
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
