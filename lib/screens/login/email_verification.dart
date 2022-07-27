import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

import '../../widgets/login_signup_header.dart';

class EmailVerification extends StatefulWidget {
  static const String routeName = 'email_verification';
  const EmailVerification({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const EmailVerification(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool isAnimated = false;
  bool _onEditing = true;
  String? _code;
  Timer? _timer;
  int _start = 123;

  @override
  void initState() {
    super.initState();
    getAnimationTime();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          if (mounted) {
            setState(() {
              timer.cancel();
            });
          }
        } else {
          if (mounted) {
            setState(() {
              _start--;
            });
          }
        }
      },
    );
  }

  void getAnimationTime() {
    if (mounted) {
      setState(() {
        isAnimated = true;
      });
    }
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        setState(() {
          isAnimated = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: !isAnimated
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                    ),
                    const LoginSiginUpHeader(
                        mainHeader: "Email Verification",
                        subheader:
                            "A verification code has been sent to your email. "),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Resend Verification Code",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    fontSize: 14,
                                    color: const Color(0xff787878)),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: VerificationCode(
                        textStyle: const TextStyle(
                            fontSize: 20.0, color: Colors.black),
                        keyboardType: TextInputType.number,
                        underlineColor: const Color(0xff787878),
                        underlineUnfocusedColor: Theme.of(context).primaryColor,
                        length: 5,
                        clearAll: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Clear',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontSize: 14),
                          ),
                        ),
                        onCompleted: (String value) {
                          setState(() {
                            _code = value;
                          });
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'user_info', (route) => false);
                        },
                        onEditing: (bool value) {
                          setState(() {
                            _onEditing = value;
                          });
                          if (!_onEditing) FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: _onEditing
                            ? Text(
                                'Please enter full code',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        fontSize: 14,
                                        color: const Color(0xff787878)),
                              )
                            : Text(
                                'Your code: $_code',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        fontSize: 14,
                                        color: const Color(0xff787878)),
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        'Verification code expires in ',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14, color: const Color(0xff787878)),
                      )),
                    ),
                    Center(
                        child: Text(
                      "$_start",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 20, color: const Color(0xff787878)),
                    ))
                  ],
                ),
              ),
            )
          : Center(
              child: Lottie.asset('assets/lottie/email.json', repeat: false),
            ),
    );
  }
}
