import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/blocs/log_bloc/log_bloc_bloc.dart';
import 'package:sanity/widgets/circular_progress.dart';
import 'package:sanity/widgets/custom_elevated_button.dart';
import 'package:sanity/widgets/custom_form.dart';

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

  void handleSubmit(BuildContext context, int id) {
    context
        .read<LogBlocBloc>()
        .add(LogSendButtonPressed(log: _writtenLogController.text, userId: id));
        context.read<LogBlocBloc>().add(RetrieveLog(id: id));
    Navigator.pop(context);
  }

  String formatDate(DateTime date) => DateFormat("dd MMMM yyy ").format(date);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: SafeArea(
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
                          color: Theme.of(context).iconTheme.color,
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
                                      color: Colors.deepPurpleAccent),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.done),
                                  )),
                            );
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.transparent,
                  ),
                  Text(
                    "Write Log",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: height * 0.045),
                  ),
                  Text(
                    formatDate(DateTime.now()),
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontSize: height * 0.035),
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(14)),
                      height: height * 0.3,
                      width: double.infinity,
                      child: CustomForm(
                        expands: true,
                        maxLines: null,
                        hintText: "Tell us how you feel.",
                        borderColor: Colors.transparent,
                        borderRadius: 14,
                        onChanged: (val) {
                          _writtenLogController.text = val;
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                              if(state is HomeLoaded){
                                return ElevatedButtonCustom(
                                  action: () => handleSubmit(context,state.user!.userId!),
                                  color: Colors.deepPurpleAccent,
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
      ),
    );
  }
}
