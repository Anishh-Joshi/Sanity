import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/dass_bloc/dass41_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/screens/home/home.dart';
import 'package:sanity/widgets/custom_elevated_button.dart';
import 'package:sanity/widgets/filead_header.dart';

class Results extends StatelessWidget {
  const Results({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppBarInfo(
                height: height,
                onPressed: () {},
                showBack: false,
                showDone: false,
                title: "Your Result"),
            BlocBuilder<Dass41Bloc, Dass41State>(
              builder: (context, state) {
                if (state is Dass41Loaded) {
                  return Text(
                    "YOUR RESULT IS ${state.category}",
                    style: Theme.of(context).textTheme.headline3!,
                  );
                }
                return const SizedBox();
              },
            ),
            const Divider(
              color: Colors.transparent,
            ),
            Text(
              "This result may help potential individuals in need of early prevention. However, the model predictions are not psychiatric diagnoses. We recommend anyone who suffers from mental health issues to call the local mental health helpline and seek professional help if possible.",
              style:
                  Theme.of(context).textTheme.headline5!.copyWith(fontSize: 14),
            ),
            const Divider(
              color: Colors.transparent,
            ),
            Text(
              "Good Luck.",
              style: Theme.of(context).textTheme.headline4!,
            ),
            const Divider(
              color: Colors.transparent,
            ),
            const Divider(
              color: Colors.transparent,
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoaded) {
                  return ElevatedButtonCustom(
                      action: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'home_landing', (route) => false,
                            arguments: state.user);
                      },
                      color: Theme.of(context).primaryColor,
                      buttonTitle: "Home");
                }
                return const SizedBox();
              },
            )
          ],
        ),
      )),
    );
  }
}
