import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/dass_bloc/dass41_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/model/das_model.dart';
import 'package:sanity/repository/das_repository/das_repo.dart';
import 'package:sanity/screens/test/response.dart';
import 'package:sanity/widgets/filead_header.dart';
import 'package:sanity/apis/utf_converter.dart';

import '../../widgets/options.dart';

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
  Map sheet = {};
  int low = 0;
  int? hight;

  bool check() {
    print("trigged");
    for (int i = 1; i <= hight!; i++) {
      if (!sheet.containsKey(i)) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Question $i is missing.")));
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (_) =>
          Dass41Bloc(repo: DasRepo())..add(const GetDas(check: false)),
      child: Scaffold(
        floatingActionButton: BlocBuilder<Dass41Bloc, Dass41State>(
          builder: (context, state) {
            if (state is Dass41Loaded) {
              return state.termsAndConditions! && !showTestScreen
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
                  child: Column(
                    children: [
                      SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor:
                                Theme.of(context).secondaryHeaderColor,
                            inactiveTrackColor: Theme.of(context).cardColor,
                            trackShape: const RectangularSliderTrackShape(),
                            trackHeight: 1.5,
                            thumbColor: Theme.of(context).primaryColor,
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 4.0),
                            overlayColor: Colors.pink.withAlpha(50),
                            overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 16.0),
                          ),
                          child: BlocBuilder<Dass41Bloc, Dass41State>(
                            builder: (context, state) {
                              if (state is Dass41Loaded) {
                                return Slider(
                                  min: 0,
                                  max: state.questions!.length.toDouble(),
                                  value: outerIndex.toDouble(),
                                  onChanged: (value) {
                                    setState(() {
                                      if (mounted) {
                                        if (value < state.questions!.length) {
                                          outerIndex = value.toInt();
                                        }
                                      }
                                    });
                                  },
                                );
                              }
                              return const SizedBox();
                            },
                          )),
                      SizedBox(
                        height: height * 0.850,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<Dass41Bloc, Dass41State>(
                              builder: (context, state) {
                            if (state is Dass41Loaded) {
                              return ListView.builder(
                                reverse: false,
                                itemCount: state.questions!.length,
                                itemBuilder: (context, index) {
                                  hight = state.questions!.length;
                                  final DasModel das = DasModel.fromJSON(
                                      resposne: state.questions![index]);

                                  return outerIndex != index
                                      ? const SizedBox()
                                      : Stack(
                                          children: [
                                            SizedBox(
                                              height: height * 0.80,
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
                                                                    height *
                                                                        0.025),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          " of ${state.questions!.length}",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline4!
                                                              .copyWith(
                                                                  fontSize:
                                                                      height *
                                                                          0.025),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          "Quit",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline6!
                                                              .copyWith(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .secondaryHeaderColor,
                                                                  fontSize:
                                                                      height *
                                                                          0.025),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const Divider(
                                                    color: Colors.transparent,
                                                  ),
                                                  Text(
                                                    Converter.utf8convert(das
                                                            .check
                                                        ? das.question
                                                        : 'I find myself ${das.question}'),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .copyWith(
                                                            fontSize:
                                                                height * 0.025),
                                                  ),
                                                  const Divider(
                                                    color: Colors.transparent,
                                                  ),
                                                  InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    onTap: () {
                                                      setState(() {
                                                        sheet[index + 1] = 1;
                                                      });
                                                    },
                                                    child: Options(
                                                        title: !das.check
                                                            ? "Disagree strongly."
                                                            : "Did not apply to me at all.",
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            sheet[index + 1] =
                                                                1;
                                                          });
                                                        },
                                                        condition:
                                                            sheet[index + 1] ==
                                                                1),
                                                  ),
                                                  InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    onTap: () {
                                                      setState(() {
                                                        sheet[index + 1] = 2;
                                                      });
                                                    },
                                                    child: Options(
                                                        title: !das.check
                                                            ? "Disagree moderately."
                                                            : "Applied to me to some degree, or some of the time.",
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            sheet[index + 1] =
                                                                2;
                                                          });
                                                        },
                                                        condition:
                                                            sheet[index + 1] ==
                                                                2),
                                                  ),
                                                  InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    onTap: () {
                                                      setState(() {
                                                        sheet[index + 1] = 3;
                                                      });
                                                    },
                                                    child: Options(
                                                        title: !das.check
                                                            ? "Disagree a little."
                                                            : "Applied to me to a considerable degree, or a good part of time.",
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            sheet[index + 1] =
                                                                3;
                                                          });
                                                        },
                                                        condition:
                                                            sheet[index + 1] ==
                                                                3),
                                                  ),
                                                  InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    onTap: () {
                                                      setState(() {
                                                        sheet[index + 1] = 4;
                                                      });
                                                    },
                                                    child: Options(
                                                        title: !das.check
                                                            ? "Neither agree nor disagree."
                                                            : "Applied to me very much, or most of the time.",
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            sheet[index + 1] =
                                                                4;
                                                          });
                                                        },
                                                        condition:
                                                            sheet[index + 1] ==
                                                                4),
                                                  ),
                                                  !das.check
                                                      ? InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          onTap: () {
                                                            setState(() {
                                                              sheet[index + 1] =
                                                                  5;
                                                            });
                                                          },
                                                          child: Options(
                                                              title:
                                                                  "Agree a little.",
                                                              onChanged: (bool?
                                                                  value) {
                                                                setState(() {
                                                                  sheet[index +
                                                                      1] = 5;
                                                                });
                                                              },
                                                              condition: sheet[
                                                                      index +
                                                                          1] ==
                                                                  5))
                                                      : SizedBox(),
                                                  !das.check
                                                      ? InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          onTap: () {
                                                            setState(() {
                                                              sheet[index + 1] =
                                                                  6;
                                                            });
                                                          },
                                                          child: Options(
                                                              title:
                                                                  "Agree moderately.",
                                                              onChanged: (bool?
                                                                  value) {
                                                                setState(() {
                                                                  sheet[index +
                                                                      1] = 6;
                                                                });
                                                              },
                                                              condition: sheet[
                                                                      index +
                                                                          1] ==
                                                                  6))
                                                      : const SizedBox(),
                                                  !das.check
                                                      ? InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          onTap: () {
                                                            setState(() {
                                                              sheet[index + 1] =
                                                                  7;
                                                            });
                                                          },
                                                          child: Options(
                                                              title:
                                                                  "Agree strongly.",
                                                              onChanged: (bool?
                                                                  value) {
                                                                setState(() {
                                                                  sheet[index +
                                                                      1] = 7;
                                                                });
                                                              },
                                                              condition: sheet[
                                                                      index +
                                                                          1] ==
                                                                  7))
                                                      : const SizedBox(),
                                                  const Divider(
                                                    color: Colors.transparent,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              child: SizedBox(
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
                                                          if (index != 0) {
                                                            setState(() {
                                                              outerIndex--;
                                                            });
                                                          }
                                                        },
                                                        child: Text(
                                                          "Previous",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline5!
                                                              .copyWith(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                        )),
                                                    RawMaterialButton(
                                                      onPressed: () {
                                                        if (index + 1 <
                                                            state.questions!
                                                                .length) {
                                                          setState(() {
                                                            outerIndex++;
                                                          });
                                                        } else {
                                                          if (check()) {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ResponsePage(
                                                                              resposne: sheet,
                                                                            )));
                                                          }
                                                        }
                                                      },
                                                      elevation: 2.0,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      fillColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      shape:
                                                          const CircleBorder(),
                                                      child: const Icon(
                                                          Icons.arrow_forward,
                                                          size: 25.0,
                                                          color: Colors.white),
                                                    )
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
                    ],
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
                                          .add(GetDas(check: value!));
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
