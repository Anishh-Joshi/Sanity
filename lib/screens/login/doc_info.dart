
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/doctor_bloc/doctor_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/model/user_info_model.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:sanity/widgets/custom_form.dart';

class DocInfo extends StatefulWidget {
  static const String routeName = 'doc_info';
  const DocInfo({Key? key}) : super(key: key);
  static Route route(RouteSettings setting) {
    return MaterialPageRoute(
        builder: (context) => const DocInfo(), settings: setting);
  }

  @override
  State<DocInfo> createState() => _DocInfoState();
}

class _DocInfoState extends State<DocInfo> {
  final TextEditingController _degree = TextEditingController();
  final TextEditingController _from = TextEditingController();
  final TextEditingController _tenure = TextEditingController();
  final TextEditingController _major = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    final UserInfoModel user = args['user'];
    return Scaffold(
      floatingActionButton:
          BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeLoaded) {
          return FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<DoctorBloc>().add(AddDocInfo(
                    profileId: state.user!.userId!,
                    isSetting: false,
                    degree: _degree.text,
                    major: _major.text,
                    from: _from.text,
                    tenure: _tenure.text));
              }
            },
            child: Icon(Icons.arrow_forward),
          );
        }
        return const SizedBox();
      }),
      body: BlocListener<DoctorBloc, DoctorState>(
        listener: (context, state) {
          if (state is DoctorListLoaded) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'home_landing', (route) => false,
                arguments: user);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            BlocBuilder<HomeBloc, HomeState>(
                              builder: (context, state) {
                                if (state is HomeLoaded) {
                                  return CircleAvatarCustom(
                                      url: state.user!.profileImgUrl!,
                                      radius: 30);
                                }
                                return const SizedBox();
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Add your Information.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(color: Colors.black),
                                  ),
                                  Text("Helps build trust.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Text("Recent certification.",
                        style: Theme.of(context).textTheme.headline5!),
                    Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14)),
                        width: double.infinity,
                        child: CustomForm(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Degree cannot be blank.';
                            }

                            return null;
                          },
                          hintText: "Eg. M.B.B.S",
                          controller: _degree,
                          borderColor: Colors.transparent,
                          borderRadius: 14,
                          onChanged: (val) {},
                        )),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Text("Major",
                        style: Theme.of(context).textTheme.headline5!),
                    Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14)),
                        width: double.infinity,
                        child: CustomForm(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Major cannot be blank.';
                            }

                            return null;
                          },
                          hintText: "Eg: Psychology.",
                          borderColor: Colors.transparent,
                          borderRadius: 14,
                          controller: _major,
                          onChanged: (val) {},
                        )),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Text("From", style: Theme.of(context).textTheme.headline5!),
                    Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14)),
                        width: double.infinity,
                        child: CustomForm(
                          controller: _from,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'University cannot be blank.';
                            }

                            return null;
                          },
                          hintText: "Eg. Kathmandu University.",
                          borderColor: Colors.transparent,
                          borderRadius: 14,
                          onChanged: (val) {},
                        )),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Text("Tenure (if any)",
                        style: Theme.of(context).textTheme.headline5!),
                    Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14)),
                        width: double.infinity,
                        child: CustomForm(
                          controller: _tenure,
                          validator: (value) {},
                          hintText:
                              " Eg. 5+ y in psychology field and 2+ y in KMC.",
                          borderColor: Colors.transparent,
                          borderRadius: 14,
                          onChanged: (val) {},
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}