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
      elevation: 1,
      iconTheme: Theme.of(context).iconTheme,
      automaticallyImplyLeading: true,
      title: Text(
        appBarTitle,
        style: Theme.of(context).textTheme.headline3,
      ),
      actions: [
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              iconData,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
