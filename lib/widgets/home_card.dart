import 'package:flutter/material.dart';

class HomeSymmaryCard extends StatelessWidget {
  const HomeSymmaryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      height: MediaQuery.of(context).size.height / 4,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Progress Summary here",
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              "Aja ko entry Missing",
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              "Aja ko Mood and suggestion",
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
