import 'package:flutter/material.dart';
import 'package:sanity/widgets/custom_appbar.dart';

class WritePage extends StatelessWidget {
  const WritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(appBarTitle: 'Daily Log', iconData: Icons.mic, onPressed: (){}),
      body: TextField(
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.transparent),
          ),
          hintText: 'Tell us about yourself',
          helperText: 'Keep it short, this is just a demo.',
        ),
        maxLines: MediaQuery.of(context).size.height.floor(),
        autofocus: true,
        cursorColor: Theme.of(context).indicatorColor,
        style: Theme.of(context).textTheme.headline3,
        keyboardType: TextInputType.multiline,
      ),
    );
  }
}
