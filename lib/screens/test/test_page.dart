import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/dass_bloc/dass41_bloc.dart';
import 'package:sanity/model/das_model.dart';
import 'package:sanity/repository/das_repository/das_repo.dart';
import 'package:sanity/widgets/custom_elevated_button.dart';
import 'package:sanity/widgets/filead_header.dart';
import 'package:sanity/apis/utf_converter.dart';

class Dass41 extends StatefulWidget {
  static const String routeName = 'dass41';
  static Route route(RouteSettings setting) {
    return MaterialPageRoute(
        builder: (context) => const Dass41(), settings: setting);
  }

  const Dass41({Key? key}) : super(key: key);

  @override
  State<Dass41> createState() => _Dass41State();
}

class _Dass41State extends State<Dass41> {
  bool showTestScreen = false;
  int outerIndex = 0;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) =>
          Dass41Bloc(repo: DasRepo())..add(const GetDas(check: false)),
      child: Scaffold(
        floatingActionButton: BlocBuilder<Dass41Bloc, Dass41State>(
          builder: (context, state) {
            if (state is Dass41Loaded) {
              return state.termsAndConditions && !showTestScreen
                  ? FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          showTestScreen = !showTestScreen;
                        });
                      },
                      child: const Icon(Icons.arrow_forward))
                  : const SizedBox();
            }
            return const SizedBox();
          },
        ),
        body: showTestScreen
            ? SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: height * 0.9,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(14)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlocBuilder<Dass41Bloc, Dass41State>(
                          builder: (context, state) {
                        if (state is Dass41Loaded) {
                          return ListView.builder(
                            reverse: false,
                            itemCount: state.questions.length,
                            itemBuilder: (context, index) {
                              final DasModel das = DasModel.fromJSON(
                                  resposne: state.questions[index]);
                              return outerIndex != index
                                  ? const SizedBox()
                                  : Stack(
                                      children: [
                                        Container(
                                          height: height * 0.86,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Question ${index + 1}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2!
                                                        .copyWith(
                                                            fontSize:
                                                                height * 0.025),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      " of ${state.questions.length}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4!
                                                          .copyWith(
                                                              fontSize:
                                                                  height * 0.025),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: (){
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Cancel",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4!
                                                        .copyWith(
                                                            fontSize:
                                                                height * 0.025),
                                                  ),)

                                                ],
                                              ),
                                              const Divider(
                                                color: Colors.transparent,
                                              ),
                                              Text(
                                                Converter.utf8convert(
                                                    das.question),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .copyWith(
                                                        fontSize:
                                                            height * 0.025),
                                              ),
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    checkColor: Colors.white,
                                                    activeColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    value: false,
                                                    shape: const CircleBorder(),
                                                    onChanged: (bool? value) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                  Text(
                                                    "I Feel it Daily",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .copyWith(
                                                            fontSize:
                                                                height * 0.020),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    checkColor: Colors.white,
                                                    activeColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    value: false,
                                                    shape: const CircleBorder(),
                                                    onChanged: (bool? value) {
                                                      
                                                      setState(() {});
                                                    },
                                                  ),
                                                  Text(
                                                    "I Feel it Daily",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .copyWith(
                                                            fontSize:
                                                                height * 0.020),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    checkColor: Colors.white,
                                                    activeColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    value: false,
                                                    shape: const CircleBorder(),
                                                    onChanged: (bool? value) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                  Text(
                                                    "I Feel it Daily",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .copyWith(
                                                            fontSize:
                                                                height * 0.020),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    checkColor: Colors.white,
                                                    activeColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    value: false,
                                                    shape: const CircleBorder(),
                                                    onChanged: (bool? value) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                  Text(
                                                    "I Feel it Daily",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .copyWith(
                                                            fontSize:
                                                                height * 0.020),
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                color: Colors.transparent,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      if(index!=0){
                                                     setState(() {
                                                      outerIndex--;
                                                    });
                                                      }
                                                    },
                                                    child: Text(
                                                      "Previous",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5!
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                    )),
                                                RawMaterialButton(
                                                  onPressed: () {
                                                   if(index+1<state.questions.length){
                                                     setState(() {
                                                      outerIndex++;
                                                    });
                                                   }else{
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("POSTED")));
                                                   }
                                                  },
                                                  elevation: 2.0,
                                                  padding: const EdgeInsets.all(10),
                                                  fillColor: Theme.of(context)
                                                      .primaryColor,
                                                  shape: const CircleBorder(),
                                                  child: const Icon(
                                                      Icons.arrow_forward,
                                                      size: 25.0,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                            },
                          );
                        }
                        return const SizedBox();
                      }),
                    ),
                  ),
                ),
              )
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBarInfo(
                          margin: 0.04,
                          height: height,
                          onPressed: () {},
                          showDone: false,
                          title: "Virtual Test"),
                      Text(
                          "The DASS-42 is a 42 item self-report scale designed to measure the negative emotional states of depression, anxiety and stress.\n\nThe principal value of the DASS in a clinical setting is to clarify the locus of emotional disturbance, as part of the broader task of clinical assessment.\n\nThe essential function of the DASS is to assess the severity of the core symptoms of depression, anxiety and stress. As the scales of the DASS have been shown to have high internal consistency and to yield meaningful discriminations in a variety of settings, the scales should meet the needs of both researchers and clinicians who wish to measure current state or change in state over time (e.g., in the course of treatment).",
                          style: Theme.of(context).textTheme.headline5!),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      BlocBuilder<Dass41Bloc, Dass41State>(
                        builder: (context, state) {
                          if (state is Dass41Loaded) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                    activeColor: Theme.of(context).primaryColor,
                                    value: state.termsAndConditions,
                                    onChanged: (bool? value) {
                                      context
                                          .read<Dass41Bloc>()
                                          .add(const GetDas(check: true));
                                    }),
                                Flexible(
                                  child: Text(
                                      "By checking this box, you are agreeing to our terms of service.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!),
                                ),
                              ],
                            );
                          }

                          return const SizedBox();
                        },
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
