import 'package:flutter/material.dart';

class TextButtonCustom extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final subtitle;
  const TextButtonCustom({ this.subtitle="See all",required this.title,  required this.onPressed, Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline2,
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            subtitle,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Theme.of(context).indicatorColor),
          ),
        ),
      ],
    );
  }
}
