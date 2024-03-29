import 'package:flutter/material.dart';

class ElevatedButtonCustom extends StatelessWidget {
  final VoidCallback action;
  final String buttonTitle;
  final IconData? icon;
  final Color color;
  final double? size;
  const ElevatedButtonCustom(
    
      {Key? key,
      this.size=18,
      required this.action,
      required this.color,
      required this.buttonTitle,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40))),
        onPressed: action,
        child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon),
                  Text(
                    buttonTitle,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.white, fontSize: size),
                  ),
                  Opacity(
                    opacity: 0,
                    child: Icon(icon),
                  )
                ],
              ),
            )));
  }
}
