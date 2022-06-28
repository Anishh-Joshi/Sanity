import 'package:flutter/material.dart';
import 'package:sanity/config/app_router.dart';
import 'package:sanity/config/theme.dart';
import 'package:sanity/screens/login/app_information.dart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanity',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: LoginInformation.routeName,
    );
  }
}
