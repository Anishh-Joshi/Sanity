import 'package:flutter/material.dart';

class MyCustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String appBarTitle;
  final IconData iconData;
  final VoidCallback onPressed;
  const MyCustomAppBar({
    Key? key,
    required this.appBarTitle,
    required this.iconData,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(appBarTitle,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          )),
      actions: [
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              iconData,
              color: Colors.black,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
