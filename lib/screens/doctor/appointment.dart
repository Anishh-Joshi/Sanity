import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/appointment/appointment_bloc.dart';
import 'package:sanity/screens/settings/account.dart';
import '../../widgets/custom_form.dart';
import '../../widgets/platform_aware.dart';

class Appointment extends StatefulWidget {
  final int doctorId;
  final int patientId;
  final bool isForDoctor;

  const Appointment({Key? key, required this.doctorId, required this.patientId, required this.isForDoctor})
      : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  final TextEditingController previousMeds = TextEditingController();
  final TextEditingController emergencyContact = TextEditingController();
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
            const PlatformAADialog(
              title: 'Appointment Request Failed',
              content: "Something went Wrong",
              defaultActionText: "Ok",
            ).show(context);
          } 
          else if(state is AppointmentRequested){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Appointment Request Made")));
            previousMeds.clear();
            emergencyContact.clear();
            Navigator.pop(context);
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
                            child: CircularProgressIndicator(),
                          );
                        }
                        return InkWell(
                          onTap: () {
                            context.read<AppointmentBloc>().add(
                                RequestAppointment(
                                    userId: widget.patientId,
                                    doctorId: widget.doctorId,
                                    previousMedicine: previousMeds.text,
                                    emergencyContact:
                                        int.tryParse(emergencyContact.text)!));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.deepPurpleAccent),
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
                const TextSettingWidget(
                  text: "Full Name",
                  state: "Anish Joshi",
                  enable: false,
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                GenderBox(height: height),
                const Divider(
                  color: Colors.transparent,
                ),
                const TextSettingWidget(
                  text: "Appointed  To",
                  state: "Dr. Eldy",
                  enable: false,
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                Row(
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
                Row(
                  children: [
                    Text(
                      "Have you taken any meds before?",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 16),
                    ),
                    Checkbox(
                        checkColor: Theme.of(context).colorScheme.secondary,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isChecked,
                        onChanged: (val) {
                          setState(() => isChecked = val!);
                        }),
                  ],
                ),
                isChecked
                    ? const Divider(
                        color: Colors.transparent,
                      )
                    : const SizedBox(),
                isChecked
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
                              hintText: "Eg: Benzodiazepine",
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
                        onChanged: (val) {
                          emergencyContact.text = val;
                        },
                        keyboardType: TextInputType.number,
                        hintText: "+977 98xxxxxxxx",
                        borderColor: Colors.transparent,
                        borderRadius: 20,
                      ),
                    )),
                  ],
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                const TextSettingWidget(
                  text: "Location",
                  state: "Kathmandu University",
                  enable: false,
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
