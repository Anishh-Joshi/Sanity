import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/apis/apis.dart';
import 'package:sanity/blocs/doctor_bloc/doctor_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:http/http.dart' as http;
import 'package:sanity/model/doctor_info_model.dart';
import 'package:sanity/model/user_info_model.dart';
import 'package:sanity/widgets/filead_header.dart';

import '../../widgets/circle_avatar.dart';
import '../../widgets/custom_form.dart';

class Doc extends StatefulWidget {
  static const String routeName = 'doc';
  const Doc({Key? key}) : super(key: key);
  static Route route(RouteSettings setting) {
    return MaterialPageRoute(
        builder: (context) => const Doc(), settings: setting);
  }

  @override
  State<Doc> createState() => _DocState();
}

class _DocState extends State<Doc> {
  TextEditingController? _degree;
  TextEditingController? _from;
  TextEditingController? _tenure;
  TextEditingController? _major;
  final _formKey = GlobalKey<FormState>();
  final APIs api = APIs();

  DoctorInfoModel? doc;
  Map? arg;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        arg = ModalRoute.of(context)!.settings.arguments as Map;
      });
      final UserInfoModel user = arg!['user'];

      getData(profileId: user.userId!);
    });

    super.initState();
  }

  getData({required int profileId}) async {
    final client = http.Client();
    final http.Response response =
        await client.get(Uri.parse(api.getDocInfo(profileId: profileId)));
    final Map info = json.decode(response.body);
    doc = DoctorInfoModel.fromJson(info['info']);
    setState(() {
      _tenure = TextEditingController(text: doc!.tenure);
      _major = TextEditingController(text: doc!.major);
      _from = TextEditingController(text: doc!.education);
      _degree = TextEditingController(text: doc!.degree);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton:
          BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeLoaded) {
          return FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<DoctorBloc>().add(AddDocInfo(
                    isSetting: true,
                    profileId: state.user!.userId!,
                    degree: _degree!.text,
                    major: _major!.text,
                    from: _from!.text,
                    tenure: _tenure!.text));

                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Updated")));
              }
            },
            child: const Icon(Icons.arrow_forward),
          );
        }
        return const SizedBox();
      }),
      body: SingleChildScrollView(
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
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoaded) {
                          return AppBarInfo(
                              height: height,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<DoctorBloc>().add(AddDocInfo(
                                      isSetting: true,
                                      profileId: state.user!.userId!,
                                      degree: _degree!.text,
                                      major: _major!.text,
                                      from: _from!.text,
                                      tenure: _tenure!.text));

                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Updated")));
                                }
                              },
                              showDone: true,
                              title: "Information");
                        }
                        return const SizedBox();
                      },
                    ),
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
                                    "Update your Information.",
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
                        style: Theme.of(context).textTheme.headline3!),
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
                          hintText: '',
                          iconData: MaterialCommunityIcons.certificate,
                          controller: _degree,
                          borderColor: Colors.transparent,
                          borderRadius: 14,
                           iconColor: Theme.of(context).primaryColor,
                          onChanged: (val) {},
                        )),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Text("Major",
                        style: Theme.of(context).textTheme.headline3!),
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
                          hintText: "",
                           iconColor: Theme.of(context).primaryColor,
                          iconData: Ionicons.ios_book_sharp,
                          borderColor: Colors.transparent,
                          borderRadius: 14,
                          controller: _major,
                          onChanged: (val) {},
                        )),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Text("From", style: Theme.of(context).textTheme.headline3!),
                    Container(
                        decoration: BoxDecoration(
                          
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14)),
                        width: double.infinity,
                        child: CustomForm(
                          iconData: Entypo.graduation_cap,
                          controller: _from,
                           iconColor: Theme.of(context).primaryColor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'University cannot be blank.';
                            }

                            return null;
                          },
                          hintText: 'state.doctorInfo!.education,',
                          borderColor: Colors.transparent,
                          borderRadius: 14,
                          onChanged: (val) {},
                        )),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Text("Tenure (if any)",
                        style: Theme.of(context).textTheme.headline3!),
                    Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14)),
                        width: double.infinity,
                        child: CustomForm(
                          controller: _tenure,
                          iconColor: Theme.of(context).primaryColor,
                          iconData:MaterialIcons.work,
                          validator: (value) {},
                          hintText: 'state.doctorInfo!.tenure,',
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
