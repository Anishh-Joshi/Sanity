

import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  final String title;
    final Function(bool?)? onChanged;
      final bool condition;
   Options({required this.title, this.onChanged, required this.condition,});

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Checkbox(
            checkColor: Colors.white,
            activeColor: Theme.of(context).primaryColor,
            value: condition,
            shape: const CircleBorder(),
            onChanged: onChanged),
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