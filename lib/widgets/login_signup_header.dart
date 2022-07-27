import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginSiginUpHeader extends StatelessWidget {
  final String mainHeader;
  final String? subheader;
  final String? lottepath;
  const LoginSiginUpHeader(
      {Key? key,
      this.lottepath,
      required this.mainHeader,
      required this.subheader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 7,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mainHeader,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontSize: 35)),
                    Text(subheader!,
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontSize: 20)),
                  ]),
            )
          ]),
        ],
      ),
      Positioned(
        right: 10,
        child: lottepath == null
            ? const SizedBox()
            : Lottie.asset(lottepath!,
                repeat: false, height: MediaQuery.of(context).size.height / 7),
      ),
    ]);
  }
}
