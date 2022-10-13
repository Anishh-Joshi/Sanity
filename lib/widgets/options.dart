import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  final String title;
  final Function(bool?)? onChanged;
  final bool condition;
  Options({
    required this.title,
    this.onChanged,
    required this.condition,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(50)),
            child: Transform.scale(
              scale: 1.4,
              child: Checkbox(
                splashRadius: 20,
                  checkColor: Colors.white,
                  activeColor: Theme.of(context).primaryColor,
                  value: condition,
                  shape: const CircleBorder(),
                  onChanged: onChanged),
            ),
          ),
        ),
        Flexible(
          child: Text(
            title,
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
