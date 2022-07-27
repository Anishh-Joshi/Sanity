

import 'dart:js';

import 'package:flutter/material.dart';
import 'package:sanity/widgets/custom_appbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        appBarTitle: "Heriz Bista",
        iconData: Icons.settings,
        onPressed: () {},
      ),
      body: myBody(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            
          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.edit)),
    );
  }

  SizedBox myBody() {
    return SizedBox(
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: topHalf(),
          ),
          Expanded(flex: 1, child: midHalf()),
          Expanded(flex: 6, child: bottomHalf()),
        ],
      ),
    );
  }

  SizedBox midHalf(
    {required BuildContext context}
  ) {
    return SizedBox(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //subMenu(),
        Flexible(
          flex: 1,
          child: Container(
            // width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
            color: Colors.white,
            child: GestureDetector(
              onTap: () {
                
                })
              },
              child: Center(
                child: RichText(
                    text: TextSpan(
                        text: 'Daily Goals',
                        //recognizer: TapGestureRecognizer()
                        //..onTap = () {
                        //print("The button is clicked");
                        //},
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(1),
                        ))),
              ),
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            //splashColor: Colors.,
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(const SnackBar(content: Text('Tap')));
            },
            child: Flexible(
              flex: 1,
              child: Container(
                // width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.5,
                color: Colors.transparent,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        tabIndex = 1;
                      });
                    },
                    child: Center(
                      child: RichText(
                          text: TextSpan(
                              text: 'Timeline View',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(1),
                              ))),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            // width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
            color: Colors.white,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  tabIndex = 2;
                });
              },
              child: Center(
                child: RichText(
                    text: TextSpan(
                        text: 'Badges',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(1),
                        ))),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Container bottomHalf() {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white.withOpacity(0.8),
    );
  }

  Container myContainerDG() {
    return Container(
      child: Text("Daily Goals"),
    );
  }

  Container myContainerTV() {
    return Container(
      child: Text("Timeline View"),
    );
  }

  Container myContainerBD() {
    return Container(
      child: Text("Badges"),
    );
  }

  SizedBox topHalf() {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          (Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            const Align(
              alignment: Alignment(0.75, 0.75),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/nature1.jpg"),
                radius: 80,
                // backgroundColor: Colors.white,
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$age',
                style: const TextStyle(
                  fontSize: 20,
                ),
              )
            ]),
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              color: Colors.yellow,
            ),
          ])),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  //   width: 20,
                  //   //color: Colors.white,
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Joined on 1st July",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 20,
                        ),
                      ),
                      Text("Active on 20 threads",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 18,
                          )),
                      Text("Address",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 15,
                          )),
                      Text("42 Entries",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 15,
                          ))
                    ],
                  )
                ]),
          )
        ],
      ),
    );
  }
}

  }
}