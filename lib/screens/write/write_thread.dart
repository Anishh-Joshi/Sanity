import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/therapy/therapy_bloc.dart';
import 'package:sanity/blocs/threads_bloc/threads_bloc.dart';

import '../../blocs/home/home_bloc.dart';
import '../../widgets/circular_progress.dart';
import '../../widgets/custom_form.dart';

class WriteThread extends StatefulWidget {
  static const String routeName = 'write_thread';

  const WriteThread({Key? key}) : super(key: key);

  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) => const WriteThread(), settings: settings);
  }

  @override
  State<WriteThread> createState() => _WriteThreadState();
}

class _WriteThreadState extends State<WriteThread> {
  final TextEditingController _contents = TextEditingController();
  final TextEditingController _title = TextEditingController();

  void handleSubmit(BuildContext context, int id) async {
    await send(id);
    _title.clear();
  }

  send(int id) async {
    context.read<ThreadsBloc>().add(
        AddThread(userId: id, title: _title.text, content: _contents.text));
    await addDat();
    _contents.clear();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Thread Added Successfully")));
    Navigator.pop(context);
  }

  addDat() {
    context.read<ThreadsBloc>().add(FetchAllThreads());
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: BlocListener<TherapyBloc, TherapyState>(
            listener: (context, state) async {
              if (state is TherapyAdditionSuccess) {
                Navigator.pop(context);
              }
              if (state is TherapyError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.err)));
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoaded) {
                            return InkWell(
                              onTap: () =>
                                  handleSubmit(context, state.user!.userId!),
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Theme.of(context).primaryColor),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                  )),
                            );
                          }
                          return const CircularProgressIndicatorCustom();
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.transparent,
                  ),
                  Text(
                    "Add Thread",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: height * 0.045),
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  const Divider(
                    color: Colors.transparent,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(14)),
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.06,
                            child: CustomForm(
                              expands: true,
                              controller: _title,
                              maxLines: null,
                              hintText: "Title",
                              borderColor: Colors.transparent,
                              borderRadius: 14,
                              onChanged: (val) {},
                            ),
                          ),
                        ],
                      )),
                  const Divider(
                    color: Colors.transparent,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(14)),
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.3,
                            child: CustomForm(
                              expands: true,
                              controller: _contents,
                              maxLines: null,
                              hintText: "Thread...",
                              borderColor: Colors.transparent,
                              borderRadius: 14,
                              onChanged: (val) {},
                            ),
                          ),
                        ],
                      )),
                  const Divider(
                    color: Colors.transparent,
                  ),
                  SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Make this sound like a two way conversation !!  ",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: height * 0.015),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text("Help",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: height * 0.015)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
