

import 'package:flutter/material.dart';
import 'package:sanity/model/med_model.dart';

class ReportDetailText extends StatelessWidget {
  final String title;
  final String? text;
  final ReportModel? report;
  const ReportDetailText(
      {this.report, required this.title, this.text, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Theme.of(context).cardColor),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headline3),
            text != null
                ? Text(text!, style: Theme.of(context).textTheme.headline4)
                : const SizedBox(),
            text != null
                ? const Divider(
                    color: Colors.transparent,
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: report!.medications.length,
                    itemBuilder: (context, index) {
                      return Text(report!.medications[index],
                          style: Theme.of(context).textTheme.headline4);
                    }),
          ],
        ),
      ),
    );
  }
}
