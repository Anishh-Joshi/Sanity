import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sanity/model/med_model.dart';
import 'package:sanity/widgets/filead_header.dart';
import 'package:sanity/widgets/report_text.dart';

class MedicationDetails extends StatelessWidget {
  final ReportModel report;
  const MedicationDetails({Key? key, required this.report}) : super(key: key);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarInfo(
                    height: height,
                    onPressed: () {},
                    showDone: false,
                    title: "Medical Report"),
                ReportDetailText(
                    title: "Examined By",
                    text: report.appointmentInformation.doctor.fullName!),
                ReportDetailText(
                    title: "Patient Name",
                    text: report.appointmentInformation.patient.fullName!),
                ReportDetailText(
                  title: "On Date",
                  text: DateFormat.yMMMMd()
                      .format(report.appointmentInformation.atTime!),
                ),
                ReportDetailText(
                  title: "Diaognosis",
                  text: report.diaognosis,
                ),
                ReportDetailText(
                  title: "Medicines",
                  report: report,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
