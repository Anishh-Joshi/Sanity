
import 'package:flutter/material.dart';

class SettingsIcon extends StatelessWidget {
      final Icon icon;
    final VoidCallback callback;
  const SettingsIcon({

    Key? key, required this.icon, required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
     onPressed: callback,
     icon: icon);
  }
}