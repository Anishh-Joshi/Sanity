import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:sanity/blocs/login/login_bloc.dart';
import '../../apis/apis.dart';
import '../../widgets/login_signup_header.dart';

class EmailVerification extends StatefulWidget {
  static const String routeName = 'email_verification';
  const EmailVerification({Key? key}) : super(key: key);
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) => const EmailVerification(), settings: settings);
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
  Map? arg;
  int? randomCode;
  bool isNameAvailable = false;

  @override
  void initState() {
    getAnimationTime();

    sendVerificationCode();
    startTimer();
    super.initState();
  }

  sendVerificationCode() async {
    await Future.delayed(Duration.zero, () {
      setState(() {
        arg = ModalRoute.of(context)!.settings.arguments as Map;
      });
    });
    setState(() {
      isNameAvailable = true;
    });
    await send(arg!['email']);
  }

  Future<Map> send(String email) async {
    var rng = Random();
    var code = rng.nextInt(90000) + 10000;
    setState(() {
      randomCode = code;
    });
    final APIs api = APIs();
    final client = http.Client();
    final http.Response response = await client.post(
        Uri.parse(api.sendVerification),
        body: jsonEncode({"email": email, "code": randomCode}),
        headers: {
          "Content-type": 'application/json',
          "Accept": "application/json",
          "Access-Control-Allow_origin": "*"
        });
    final loginResponse = json.decode(response.body);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Verification code sent!")));
    return loginResponse;
  }

  Future<bool> setTick() async {
    final APIs api = APIs();
    final client = http.Client();
    final http.Response response = await client
        .put(Uri.parse(api.setEmailVerified(id: arg!['id'])), headers: {
      "Content-type": 'application/json',
      "Accept": "application/json",
      "Access-Control-Allow_origin": "*"
    });
    final loginResponse = json.decode(response.body);
    if (loginResponse["status"] == "success") {
      return true;
    }
    return false;
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
              randomCode = null;
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Verification timeout!")));
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
                    LoginSiginUpHeader(
                        mainHeader: "Email Verification",
                        subheader:
                            "A verification code has been sent to ${isNameAvailable ? arg!['email'] : ''}. "),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _start = 123;
                              startTimer();
                            });
                          },
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
                        textStyle: Theme.of(context).textTheme.headline6!,
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
                        onCompleted: (String value) async {
                          setState(() {
                            _code = value;
                          });
                          if (_code == randomCode.toString()) {
                            bool val = await setTick();
                            if (val) {
                              if (mounted) {
                                context.read<LoginBloc>().add(LoginCheck());
                                Navigator.pushNamedAndRemoveUntil(
                                    context, 'landing_page', (route) => false);
                              }
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Verification code did not match!")));
                          }
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
                    )),
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
