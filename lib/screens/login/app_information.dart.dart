import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginInformation extends StatefulWidget {
  static const String routeName = 'loginInfo';
  LoginInformation({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => LoginInformation(),
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
      "text": "With sanity you can have a clear insights of your thoughts",
      "bottom_text": "Let's Get Started",
      "repeat": false
    },
    {
      "screen": 2,
      "lottePath": "assets/lottie/meditation.json",
      "text": "With sanity you can have a clear insights of your thoughts",
      "bottom_text": "Almost done...",
      "repeat": false,
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
      body: SafeArea(
        child: Column(
          children: [
            Stack(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: Lottie.asset(infoData[index]['lottePath'],
                    width: double.infinity, repeat: infoData[index]['repeat']),
              ),
              Positioned(
                bottom: 0,
                left: MediaQuery.of(context).size.width / 3.2,
                child: Container(
                  height: 150,
                  width: 150,
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 18),
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
                    .headline2!
                    .copyWith(color: const Color.fromARGB(255, 201, 201, 201)),
              ),
            ),
          ),
          Text(
            infoData[index]['bottom_text'],
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: const Color.fromARGB(255, 201, 201, 201)),
          ),
          FloatingActionButton(
            onPressed: () {
              if (index < 2) {
                setState(() {
                  index++;
                });
              } else {
                Navigator.pushNamed(context, 'login');
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
