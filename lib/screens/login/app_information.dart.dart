import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
      "lottePath": "assets/lottie/doctor.json",
      "text": "Welcome to Sanity!",
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
      "text": "With sanity you can have a clear insights of your thoughts",
      "bottom_text": "Login/Register",
      "repeat": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 242, 242),
        elevation: 0,
        leading: index == 0
            ? const SizedBox()
            : IconButton(
                onPressed: () {
                  if (index != 0) {
                    setState(() {
                      index--;
                    });
                  }
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
      ),
      backgroundColor: const Color.fromARGB(255, 243, 242, 242),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
        child: Column(
          children: [
            Stack(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: Lottie.asset(infoData[index]['lottePath'],
                    width: MediaQuery.of(context).size.height / 2.5,
                    repeat: infoData[index]['repeat']),
              ),
              Positioned(
                bottom: 50,
                left: MediaQuery.of(context).size.width / 3.5,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.amber,
                  ),
                  child: Center(
                    child: Text("Sanity",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.white)),
                  ),
                ),
              )
            ]),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                    infoData[index]['text'],
                    textAlign: TextAlign.center,
                    style: index == 0
                        ? Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 25,
                            color: Color.fromARGB(255, 160, 158, 158))
                        : Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 23,
                            color: Color.fromARGB(255, 160, 158, 158)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Opacity(
            opacity: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 80.0),
              child: Text(
                "L",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: const Color.fromARGB(255, 201, 201, 201)),
              ),
            ),
          ),
          Text(
            infoData[index]['bottom_text'],
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 20, color: const Color.fromARGB(255, 160, 158, 158)),
          ),
          FloatingActionButton(
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
            backgroundColor: Colors.amber,
            child: const Icon(
              Icons.arrow_forward,
            ),
          ),
        ],
      ),
    );
  }
}
