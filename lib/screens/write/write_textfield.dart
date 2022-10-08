import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/blocs/log_bloc/log_bloc_bloc.dart';
import 'package:sanity/widgets/circular_progress.dart';
import 'package:sanity/widgets/custom_elevated_button.dart';
import 'package:sanity/widgets/custom_form.dart';
import 'package:sanity/widgets/filead_header.dart';

class WriteField extends StatefulWidget {
  static const String routeName = 'write_field';

  const WriteField({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
        builder: (context) => const WriteField(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  State<WriteField> createState() => _WriteFieldState();
}

class _WriteFieldState extends State<WriteField> {
  final TextEditingController _writtenLogController = TextEditingController();

  void handleSubmit(BuildContext context, int id) async {
    context
        .read<LogBlocBloc>()
        .add(LogSendButtonPressed(log: _writtenLogController.text, userId: id));
    Navigator.pop(context);
  }

  String formatDate(DateTime date) => DateFormat("dd MMMM yyy ").format(date);
  @override
  void dispose() {
    _writtenLogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoaded) {
                      return AppBarInfo(
                        margin :0 ,
                          height: height,
                          onPressed: () {
                            handleSubmit(context, state.user!.userId!);
                          },
                          showDone: true,
                          title: "Write Log");
                    }
                    return const CircularProgressIndicatorCustom();
                  },
                ),
                Text(
                  formatDate(DateTime.now()),
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: height * 0.030),
                ),
                SizedBox(
                  height: height * 0.07,
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
                            controller: _writtenLogController,
                            maxLines: null,
                            hintText: "Tell us how you feel.",
                            borderColor: Colors.transparent,
                            borderRadius: 14,
                            onChanged: (val) {},
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(14)),
                          height: height * 0.05,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.mic),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    _writtenLogController.clear();
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is HomeLoaded) {
                              return ElevatedButtonCustom(
                                  action: () => handleSubmit(
                                      context, state.user!.userId!),
                                  color: Theme.of(context).primaryColor,
                                  buttonTitle: "Save");
                            }
                            return const CircularProgressIndicatorCustom();
                          },
                        )),
                  ),
                ),
                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't worry your daily log is safe with us!!  ",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: height * 0.015),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text("Read More",
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
    );
  }
}
