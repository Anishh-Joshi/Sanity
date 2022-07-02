import 'package:flutter/material.dart';

class LoginBubble extends StatefulWidget {
  LoginBubble({Key? key}) : super(key: key);

  @override
  State<LoginBubble> createState() => _LoginBubbleState();
}

class _LoginBubbleState extends State<LoginBubble> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.red,
                      Colors.pink,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(0),
                      bottomRight: Radius.circular(30))),
              height: MediaQuery.of(context).size.height / 5.5,
              width: MediaQuery.of(context).size.width / 2,
            ),
          ),
          Positioned(
            left: 16,
            top: 100,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.red,
                      Colors.pink,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(70))),
              height: MediaQuery.of(context).size.height / 15,
              width: MediaQuery.of(context).size.width / 8,
            ),
          ),
          Positioned(
            right: 16,
            top: MediaQuery.of(context).size.height / 2,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.red,
                      Colors.pink,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(70))),
              height: MediaQuery.of(context).size.height / 15,
              width: MediaQuery.of(context).size.width / 8,
            ),
          ),
        ],
      ),
    );
  }
}
