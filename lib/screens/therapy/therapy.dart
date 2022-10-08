import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:sanity/apis/apis.dart';
import 'package:sanity/blocs/therapy/therapy_bloc.dart';
import 'package:sanity/screens/therapy/therapy_details.dart';
import 'package:sanity/widgets/circular_progress.dart';
import 'package:sanity/widgets/custom_elevated_button.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../model/therapy_model.dart';
import '../../widgets/circle_avatar.dart';
import 'package:http/http.dart' as http;

class Therapy extends StatelessWidget {
  static const String routeName = 'therapy_info';
  final APIs api = APIs();

  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) => Therapy(), settings: settings);
  }

   Therapy({Key? key}) : super(key: key);
  String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  Future<Map> addInvolved(int id)async{
    final client = http.Client();
    final http.Response response =
        await http.put(Uri.parse(api.incrementInvolved(id:id)),);
    final appointmentResponse = json.decode(response.body);
    return appointmentResponse;

  }

  @override
  Widget build(BuildContext context) {
    final TherapyModel therapy =
        ModalRoute.of(context)!.settings.arguments as TherapyModel;

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocBuilder<TherapyBloc, TherapyState>(
        builder: (context, state) {
          if (state is TherapyLoading) {
            return const Text("hello");
          }

          if(state is TherapyLoaded){
                return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      const Divider(
                        color: Colors.transparent,
                      ),
                      Text(
                        therapy.title!,
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: height * 0.03),
                      ),
                      SizedBox(
                        height: height * 0.006,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatarCustom(
                                      url: therapy.byDoctor!
                                          .profileImgUrl!,
                                      radius: height * 0.02),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Dr.${therapy.byDoctor!.fullName.toString()}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(fontSize: height * 0.018),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.006,
                              ),
                              SizedBox(
                                height: height * 0.006,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Fontisto.music_note,
                                    size: height * 0.018,
                                  ),
                                  SizedBox(
                                    width: height * 0.013,
                                  ),
                                  Text(
                                    "Chill music",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                            color: Colors.grey,
                                            fontSize: height * 0.016),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.006,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Fontisto.clock,
                                    size: height * 0.016,
                                  ),
                                  SizedBox(
                                    width: height * 0.013,
                                  ),
                                  Text(
                                    timeago.format(therapy.createdAt!),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                            color: Colors.grey,
                                            fontSize: height * 0.015),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                therapy.category! +
                                    " " +
                                    utf8convert(therapy.emoji!),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(fontSize: height * 0.016),
                              ),
                              const Divider(
                                color: Colors.transparent,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Theme.of(context).primaryColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${therapy.involved??0} + involved",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize: height * 0.015),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      Expanded(
                          child: Lottie.asset('assets/lottie/therapy.json',
                              height: height * 0.3)),
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: width * 0.5,
                            child: ElevatedButtonCustom(
                                size: 16,
                                action: () {
                                  addInvolved(therapy.therapyId!);
                                  Navigator.pushNamed(
                                      context, TherapyDetails.routeName);
                                },
                                color: Theme.of(context).secondaryHeaderColor,
                                buttonTitle: "Start Now"),
                          )),
                    ]),
              ),
            );

          }
          return const CircularProgressIndicatorCustom();
        },
      ),
    );
  }
}
