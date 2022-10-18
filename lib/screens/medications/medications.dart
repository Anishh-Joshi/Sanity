import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sanity/blocs/report_bloc/report_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/model/appointment_model.dart';
import 'package:sanity/model/med_model.dart';
import 'package:sanity/screens/medications/medication_details.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:sanity/widgets/filead_header.dart';
import 'package:timeago/timeago.dart' as timeago;

class Medications extends StatelessWidget {
  const Medications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
             physics:const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                AppBarInfo(
                    height: height,
                    onPressed: () {},
                    showBack: false,
                    showDone: false,
                    title: "Reports"),
                BlocBuilder<ReportBloc, ReportState>(
                  builder: (context, state) {
                    if (state is ReportLoaded) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.reports!.length,
                        itemBuilder: (context, index) {
                          final ReportModel report =
                              ReportModel.fromJSON(state.reports![index]);
                          return ReportCard(
                            report: report,
                          );
                        },
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

class ReportCard extends StatelessWidget {
  final ReportModel report;
  const ReportCard({
    Key? key,
    required this.report,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          return Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MedicationDetails(
                              report: report,
                            )));
              },
              leading: CircleAvatarCustom(
                  url: state.user!.isDoctor! &&
                          (report.appointmentInformation.doctor.userId ==
                              state.user!.userId)
                      ? report.appointmentInformation.patient.profileImgUrl!
                      : report.appointmentInformation.doctor.profileImgUrl!,
                  radius: 20),
              title: Text(DateFormat.yMMMMd().format(DateTime.parse(
                  report.appointmentInformation.atTime.toString())),style: Theme.of(context).textTheme.headline4,),
              subtitle: Text(
                state.user!.isDoctor! &&
                        (report.appointmentInformation.doctor.userId ==
                            state.user!.userId)
                    ? report.appointmentInformation.patient.fullName!
                    : report.appointmentInformation.doctor.fullName!,
                style: Theme.of(context).textTheme.headline5,
              ),
              trailing: Text(timeago.format(report.createdAt)),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
