import 'package:flutter/material.dart';

class FloatingButon extends StatelessWidget {
  final VoidCallback callback;

  const FloatingButon({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: callback,
      backgroundColor: Theme.of(context).primaryColor,
      child: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
    );
  }
}
