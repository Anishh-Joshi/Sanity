import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:sanity/blocs/appointment/appointment_bloc.dart';
import 'package:sanity/model/appointment_model.dart';
import 'package:sanity/model/user_info_model.dart';
import 'package:sanity/repository/auth_repo.dart';
import 'package:sanity/screens/doctor/appointment.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:sanity/widgets/circular_progress.dart';

class AppointmentInformation extends StatefulWidget {
  final UserInfoModel user;

  const AppointmentInformation({Key? key, required this.user})
      : super(key: key);

  @override
  State<AppointmentInformation> createState() => _AppointmentInformationState();
}

class _AppointmentInformationState extends State<AppointmentInformation> {
  bool isPendingScreen = false;
  @override
  Widget build(BuildContext context) {
    context
        .read<AppointmentBloc>()
        .add(RetrieveAppointmentDoctor(doctorId: widget.user.userId!));
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Appointments",
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontSize: height * 0.045),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Options(
                  title: "Appointments",
                  action: () {
                    setState(() {
                      isPendingScreen = false;
                    });
                  },
                  color: isPendingScreen
                      ? Theme.of(context).cardColor
                      : Colors.deepOrangeAccent,
                ),
                Options(
                  color: !isPendingScreen
                      ? Theme.of(context).cardColor
                      : Colors.deepOrangeAccent,
                  title: "Pending",
                  action: () {
                    setState(() {
                      isPendingScreen = true;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: height * 0.03,
            ),
            VerifiedAppointments(
              height: height,
              isPendingScreen: isPendingScreen,
            )
          ],
        ),
      ),
    ));
  }
}

class VerifiedAppointments extends StatelessWidget {
  final bool isPendingScreen;
  const VerifiedAppointments(
      {Key? key, required this.height, required this.isPendingScreen})
      : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        if (state is AppointmentLoadng) {
          return const CircularProgressIndicatorCustom();
        } else if (state is AppointmentRetrieved) {
          return Expanded(
            child: ListView.builder(
                itemCount: state.appointmentList.length,
                itemBuilder: (context, index) {
                  final AppointmentModel appointModel =
                      AppointmentModel.fromJSON(state.appointmentList[index]);
                  return !isPendingScreen
                      ? appointModel.pending!
                          ? const SizedBox()
                          : AppointmentCard(
                            height: height,
                            appointmentMOdel: appointModel,
                            )
                      : !appointModel.pending!
                          ? const SizedBox()
                          : AppointmentCard(
                            height: height,
                            appointmentMOdel: appointModel,
                            );
                }),
          );
        }
        return const CircularProgressIndicatorCustom();
      },
    );
  }
}

class AppointmentCard extends StatefulWidget {
  final AppointmentModel appointmentMOdel;
  const AppointmentCard({
    Key? key,
    required this.height, required this.appointmentMOdel,
  }) : super(key: key);

  final double height;

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  bool isLoading = false;
   UserInfoModel patient =const UserInfoModel();
  

  Future<UserInfoModel> getProfileDate(int id) async {

    final AuthRepository repo = AuthRepository();
    setState(() {
      isLoading = true;
    });

    final Map profile = await repo.registeredProfileData(id: id);
    final Map candidates = profile['candidates'];
    
    setState(() {
      patient = UserInfoModel.fromJson(candidates);
      isLoading = false;
    });
    return patient;
  }

  @override
  void initState(){
    getProfileDate(widget.appointmentMOdel.patientName!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return isLoading?const SizedBox(): InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Appointment(
                  patient: patient,
                    isForDoctor: true,
                    appointmentModel: widget.appointmentMOdel)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatarCustom(url: patient.profileImgUrl!, radius: widget.height * 0.05),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient.fullName!,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        patient.gender!,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        patient.age!.toString(),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            AntDesign.clockcircleo,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text("15 September 2022, 4 pm",
                              style: Theme.of(context).textTheme.headline6),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              widget.appointmentMOdel.pending!
                  ? Column(
                      children: [
                        const Icon(
                          MaterialIcons.pending,
                          color: Colors.pink,
                        ),
                        Text(
                          "Pending",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class Options extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback action;
  const Options({
    Key? key,
    required this.title,
    required this.action,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      onTap: action,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: color),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline4,
            ),
          )),
    );
  }
}
