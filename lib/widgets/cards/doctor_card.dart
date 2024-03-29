import 'package:flutter/material.dart';
import 'package:sanity/widgets/circle_avatar.dart';

class DoctorCard extends StatelessWidget {
  final String doctorName;
  final String gender;
  final String location;
  final String hospitalName;
  final String profileUrl;
  final int nmcId;
  final int handlingPatients = 30;
  const DoctorCard(
      {Key? key,
      required this.doctorName,
      required this.gender,
      required this.location,
      required this.profileUrl,
      required this.nmcId,
      required this.hospitalName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          CircleAvatarCustom(url: profileUrl, radius: 35),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(doctorName,
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 18)),
                  Text(hospitalName,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: 14)),
                  Text('Lives in $location',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: 14)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('Handling $handlingPatients patients',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontSize: 14)),
                        Row(
                          children: const [
                            Icon(
                              Icons.diamond,
                              color: Colors.blue,
                            ),
                            Text("24")
                          ],
                        )
                      ])
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
