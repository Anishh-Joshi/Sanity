import 'package:flutter/material.dart';

class MyCustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String appBarTitle;
  final IconData? iconData;
  final VoidCallback? onPressed;
  final double elevation;
  final double? fontSize;
  const MyCustomAppBar({
    Key? key,
    required this.appBarTitle,
    this.iconData,
    this.elevation = 1,
    this.fontSize,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      iconTheme: Theme.of(context).iconTheme,
      automaticallyImplyLeading: false,
      title: Text(
        appBarTitle,
        style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: fontSize),
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
