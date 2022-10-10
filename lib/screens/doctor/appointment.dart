import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/appointment/appointment_bloc.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/model/user_info_model.dart';
import 'package:sanity/screens/settings/account.dart';
import 'package:sanity/widgets/circular_progress.dart';
import 'package:sanity/widgets/custom_elevated_button.dart';
import '../../model/appointment_model.dart';
import '../../widgets/custom_form.dart';
import '../../widgets/platform_aware.dart';

class Appointment extends StatefulWidget {
  final AppointmentModel? appointmentModel;
  final UserInfoModel? patient;
  final int? doctorId;
  final int? patientId;
  final bool isForDoctor;
  final String? doctorName;

  const Appointment(
      {Key? key,
      this.doctorId,
      this.patient,
      this.doctorName,
      this.patientId,
      required this.isForDoctor,
      this.appointmentModel})
      : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  DateTime? _pickedDate;
  TimeOfDay? timeOfDay;
  @override
  void initState() {
    _pickedDate = DateTime.now();
    timeOfDay = TimeOfDay.now();
    super.initState();
  }

  final TextEditingController previousMeds = TextEditingController();
  final TextEditingController emergencyContact = TextEditingController();
  List months = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec'
  ];
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.amberAccent;
    }
    return Theme.of(context).primaryColor;
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocListener<AppointmentBloc, AppointmentState>(
        bloc: context.read<AppointmentBloc>(),
        listener: (context, state) {
          if (state is AppointmentError) {
            PlatformAADialog(
              title: 'Appointment Request Failed',
              content: state.err,
              defaultActionText: "Ok",
            ).show(context);
          } else if (state is AppointmentRequested) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Appointment Request Made")));
            previousMeds.clear();
            emergencyContact.clear();
            Navigator.pop(context);
          } else if (state is AppointmentLoaded && widget.isForDoctor) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Appointment Verified")));

            context.read<AppointmentBloc>().add(RetrieveAppointmentDoctor(
                doctorId: widget.appointmentModel!.doctor.userId!));
          }
        },
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                    BlocBuilder<AppointmentBloc, AppointmentState>(
                      builder: (context, state) {
                        if (state is AppointmentLoadng) {
                          return const Center(
                            child: CircularProgressIndicatorCustom(),
                          );
                        }
                        return InkWell(
                          onTap: () {
                            DateTime finalDateTime = DateTime(
                                _pickedDate!.year,
                                _pickedDate!.month,
                                _pickedDate!.day,
                                timeOfDay!.hour,
                                timeOfDay!.minute);

                            if (widget.isForDoctor) {
                              //trigger notificstion pani

                              context.read<AppointmentBloc>().add(
                                  UpdateAppointmentDoctor(
                                      time: finalDateTime,
                                      appointmentId: widget
                                          .appointmentModel!.appointmentId!));
                              Navigator.pop(context);
                            } else {
                              context.read<AppointmentBloc>().add(
                                  RequestAppointment(
                                      userId: widget.patientId!,
                                      doctorId: widget.doctorId!,
                                      previousMedicine: previousMeds.text,
                                      emergencyContact: int.tryParse(
                                          emergencyContact.text)!));
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Theme.of(context).primaryColor),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.done,
                                  color: Colors.white,
                                ),
                              )),
                        );
                      },
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                Text(
                  "Appointment",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: height * 0.045),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                widget.isForDoctor
                    ? TextSettingWidget(
                        text: "Full Name",
                        state: widget.patient!.fullName!,
                        enable: false,
                      )
                    : BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoaded) {
                            return TextSettingWidget(
                              text: "Full Name",
                              state: state.user!.fullName!,
                              enable: false,
                            );
                          }
                          return const CircularProgressIndicatorCustom();
                        },
                      ),
                const Divider(
                  color: Colors.transparent,
                ),
                widget.isForDoctor
                    ? GenderBox(
                        isAccountView: false,
                        gender: widget.patient!.gender!,
                        height: height)
                    : BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoaded) {
                            return GenderBox(
                                isAccountView: false,
                                gender: state.user!.gender!,
                                height: height);
                          }
                          return const SizedBox();
                        },
                      ),
                const Divider(
                  color: Colors.transparent,
                ),
                widget.isForDoctor
                    ? BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoaded) {
                            return TextSettingWidget(
                              text: "Appointed to",
                              state: state.user!.fullName!,
                              enable: false,
                            );
                          }
                          return const CircularProgressIndicatorCustom();
                        },
                      )
                    : TextSettingWidget(
                        text: "Appointed to",
                        state: widget.doctorName!,
                        enable: false,
                      ),
                const Divider(
                  color: Colors.transparent,
                ),
                widget.isForDoctor
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Date",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(left: width * 0.20),
                                  child: SizedBox(
                                      child: ElevatedButtonCustom(
                                          action: () async {
                                            DateTime? dateTime =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: _pickedDate!,
                                                    firstDate: DateTime(
                                                        DateTime.now().year),
                                                    lastDate: DateTime(
                                                        DateTime.now().year +
                                                            100));
                                            if (dateTime != null) {
                                              setState(() {
                                                _pickedDate = dateTime;
                                              });
                                            }
                                          },
                                          color: Theme.of(context).primaryColor,
                                          buttonTitle:
                                              months[_pickedDate!.month - 1]
                                                      .toString()
                                                      .toUpperCase() +
                                                  " " +
                                                  _pickedDate!.day.toString())),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Time",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(left: width * 0.20),
                                  child: SizedBox(
                                      child: ElevatedButtonCustom(
                                          action: () async {
                                            TimeOfDay? t = await showTimePicker(
                                                context: context,
                                                initialTime: timeOfDay!);
                                            if (t != null) {
                                              setState(() {
                                                timeOfDay = t;
                                              });
                                            }
                                          },
                                          color: Theme.of(context).primaryColor,
                                          buttonTitle: timeOfDay!.hour
                                                  .toString() +
                                              ":" +
                                              timeOfDay!.minute.toString())),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Timing",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          SizedBox(
                            width: width * 0.2,
                          ),
                          Expanded(
                            child: Text(
                              "Once you receive an approval from the doctor, the timing of your appointment will be attached to it.",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          )
                        ],
                      ),
                const Divider(
                  color: Colors.transparent,
                ),
                widget.isForDoctor
                    ? const SizedBox()
                    : Row(
                        children: [
                          Text(
                            "Have you taken any meds before?",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(fontSize: 16),
                          ),
                          Checkbox(
                              checkColor:
                                  Theme.of(context).colorScheme.secondary,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: isChecked,
                              onChanged: (val) {
                                setState(() => isChecked = val!);
                              }),
                        ],
                      ),
                isChecked && !widget.isForDoctor
                    ? const Divider(
                        color: Colors.transparent,
                      )
                    : const SizedBox(),
                (isChecked || widget.isForDoctor)
                    ? Row(
                        children: [
                          Text(
                            "Medicine Name",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(fontSize: 16),
                          ),
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: CustomForm(
                              onChanged: (val) {
                                previousMeds.text = val;
                              },
                              enabled: widget.isForDoctor ? false : true,
                              hintText: widget.isForDoctor
                                  ? "${widget.appointmentModel!.previousMedications}"
                                  : "Eg: Benzodiazepine",
                              borderColor: Colors.transparent,
                              borderRadius: 20,
                            ),
                          )),
                        ],
                      )
                    : const SizedBox(),
                const Divider(
                  color: Colors.transparent,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Emergency contact",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 16),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: CustomForm(
                        enabled: widget.isForDoctor ? false : true,
                        onChanged: (val) {
                          emergencyContact.text = val;
                        },
                        keyboardType: TextInputType.number,
                        hintText: widget.isForDoctor
                            ? "${widget.appointmentModel!.emergencyContact}"
                            : "+977 98xxxxxxxx",
                        borderColor: Colors.transparent,
                        borderRadius: 20,
                      ),
                    )),
                  ],
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                widget.isForDoctor
                    ? TextSettingWidget(
                        text: "Location",
                        state: widget.patient!.address!,
                        enable: false,
                      )
                    : BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoaded) {
                            return TextSettingWidget(
                              text: "Location",
                              state: state.user!.address!,
                              enable: false,
                            );
                          }
                          return const CircularProgressIndicatorCustom();
                        },
                      ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
