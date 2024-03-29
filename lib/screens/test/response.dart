import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/screens/test/result.dart';
import 'package:sanity/widgets/custom_form.dart';
import 'package:sanity/widgets/filead_header.dart';

import '../../blocs/dass_bloc/dass41_bloc.dart';
import '../../model/question_map.dart';
import '../../widgets/options.dart';

class ResponsePage extends StatefulWidget {
  final Map resposne;

  const ResponsePage({Key? key, required this.resposne}) : super(key: key);

  @override
  State<ResponsePage> createState() => _ResponsePageState();
}

class _ResponsePageState extends State<ResponsePage> {
  int hight = 8;
  final Map selected = {};

  bool check() {
    for (int i = 1; i <= hight; i++) {
      if (!selected.containsKey(i)) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Question $i is missing.")));
        return false;
      }
    }
    return true;
  }

  void handleSubmit({required int profileId, required BuildContext context}) {
    if (check()) {
      context.read<Dass41Bloc>().add(SendDas(
          anotherrespone: selected,
          responseSheet: widget.resposne,
          profileId: profileId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            return FloatingActionButton(
              onPressed: () {
                handleSubmit(profileId: state.user!.userId!, context: context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Results()));
              },
              child: const Icon(Icons.done),
            );
          }
          return const SizedBox();
        },
      ),
      body: BlocListener<Dass41Bloc, Dass41State>(
        listener: (context, state) {
          print(state);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarInfo(
                    height: height,
                    onPressed: () {},
                    showDone: false,
                    title: "Almost Done"),
                SizedBox(
                  height: height * 0.79,
                  child: ListView.builder(
                      itemCount: QuestionMap.options.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(color: Colors.transparent),
                            Row(
                              children: [
                                Text(
                                  QuestionMap.options[index]['cat']
                                          .contains('Family')
                                      ? "${index + 1}/ Enter your "
                                      : "${index + 1}/ Select your ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(fontSize: height * 0.025),
                                ),
                                Text(
                                  "${QuestionMap.options[index]['cat']}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(fontSize: height * 0.025),
                                ),
                              ],
                            ),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: QuestionMap
                                    .options[index]['options'].length,
                                itemBuilder: (context, ind) {
                                  return QuestionMap.options[index]['cat']
                                          .contains('Family')
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 40, right: 80),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color:
                                                    Theme.of(context).cardColor,
                                                borderRadius:
                                                    BorderRadius.circular(14)),
                                            child: CustomForm(
                                              keyboardType:
                                                  TextInputType.number,
                                              hintText: "Eg. 3",
                                              borderColor: Colors.transparent,
                                              borderRadius: 14,
                                              onChanged: (val) {
                                                setState(() {
                                                  selected[index + 1] = val;
                                                });
                                              },
                                            ),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            setState(() {
                                              selected[index + 1] = ind + 1;
                                            });
                                          },
                                          child: Options(
                                              onChanged: (bool? val) {
                                                setState(() {
                                                  selected[index + 1] = ind + 1;
                                                });
                                              },
                                              title: QuestionMap.options[index]
                                                      ['options'][ind]
                                                  .toString(),
                                              condition: selected[index + 1] ==
                                                  ind + 1),
                                        );
                                })
                          ],
                        );
                      }),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
