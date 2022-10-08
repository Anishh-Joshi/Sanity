import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/therapy/therapy_bloc.dart';

import '../../blocs/home/home_bloc.dart';
import '../../widgets/circular_progress.dart';
import '../../widgets/custom_form.dart';

class AddTherapy extends StatefulWidget {
  static const String routeName = 'ad_therapy';

  const AddTherapy({Key? key}) : super(key: key);

  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) => const AddTherapy(), settings: settings);
  }

  @override
  State<AddTherapy> createState() => _AddTherapyState();
}

class _AddTherapyState extends State<AddTherapy> {
  final TextEditingController _contents = TextEditingController();
  final TextEditingController _title = TextEditingController();

  String? category = "Anxiety";
  List? genderChoice = [
    "Anxiety",
    "Depression",
    "Stress",
    "Suicidal",
    "Insecurities",
    "Helpless",
    "Sadness",
    "Trauma",
    "Anger",
    "Body Acceptance"
  ];

  void handleSubmit(BuildContext context, int id) async {
    await send(id);
    await call();
  }

  Future<void> send(int id) async {
    context.read<TherapyBloc>().add(AddTherapyData(
        docId: id,
        category: category!,
        title: _title.text,
        contents: _contents.text));
  }

  Future<void> call() async {
    context.read<TherapyBloc>().add(GetAllTherapy());
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: BlocListener<TherapyBloc, TherapyState>(
            listener: (context, state) async{
              if (state is TherapyAdditionSuccess) {
              
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Therapy Added Successfully")));
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
                                      color: Theme.of(context).primaryColor),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.done,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
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
                    "Add Therapy",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: height * 0.045),
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Text("Category",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 15,
                                  )),
                          dropdownColor: Theme.of(context).cardColor,
                          value: category,
                          onChanged: (newValue) {
                            category = newValue.toString();

                            setState(() {});
                          },
                          items: genderChoice!.map((valueItem) {
                            return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                          fontSize: 15,
                                        )));
                          }).toList(),
                        ),
                      ),
                    ),
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
                              hintText:
                                  "Title. example: Do you feel insecure aound people?",
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
                            height: height * 0.5,
                            child: CustomForm(
                              expands: true,
                              controller: _contents,
                              maxLines: null,
                              hintText: "Start with Hey,",
                              borderColor: Colors.transparent,
                              borderRadius: 14,
                              onChanged: (val) {},
                            ),
                          ),
                        ],
                      )),
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
