import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/report_bloc/report_bloc.dart';
import 'package:sanity/model/appointment_model.dart';
import 'package:sanity/widgets/custom_form.dart';
import 'package:sanity/widgets/filead_header.dart';
import 'package:sanity/widgets/platform_aware.dart';

class MakeReport extends StatefulWidget {
  final AppointmentModel appointment;
  const MakeReport({required this.appointment, Key? key}) : super(key: key);

  @override
  State<MakeReport> createState() => _MakeReportState();
}

class _MakeReportState extends State<MakeReport> {
  int fields = 1;
  Map medicines = {};
  final TextEditingController _diaognosis = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return BlocListener<ReportBloc, ReportState>(
      listener: (context, state) {
        if (state is ReportLoaded) {
          setState(() {
            _diaognosis.clear();
            medicines = {};
            fields = 1;
          });

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  "Report made and sent to ${widget.appointment.patient.fullName}")));
        } else if (state is ReportError) {
          PlatformAADialog(
            content: state.msg,
            title: 'Duplicate report',
            defaultActionText: 'Ok',
          ).show(context);
        }
      },
      child: Scaffold(
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
                    showBack: false,
                    margin: 0,
                    onPressed: () {
                      context.read<ReportBloc>().add(SendReport(
                          appointment: widget.appointment,
                          reportData: medicines,
                          diaognosis: _diaognosis.text));
                    },
                    showDone: true,
                    title: "Report for"),
                Text(
                  "${widget.appointment.patient.fullName} ",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontSize: 20),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(14)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Diaognosis",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 17),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                Container(
                    height: height * 0.3,
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(14)),
                    child: CustomForm(
                      controller: _diaognosis,
                      borderColor: Colors.transparent,
                      borderRadius: 16,
                      hintText:
                          "Type in your Diaognosis for ${widget.appointment.patient.fullName} here",
                    )),
                const Divider(
                  color: Colors.transparent,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(14)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Medicines",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 17),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14)),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  fields++;
                                });
                              },
                              child: const Icon(Icons.add),
                            )),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: fields,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: height * 0.05,
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(14)),
                          child: CustomForm(
                            borderColor: Colors.transparent,
                            borderRadius: 16,
                            onChanged: (value) {
                              medicines[index] = value;
                            },
                            hintText:
                                "Type in your Medcation for ${widget.appointment.patient.fullName} here.",
                          )),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
