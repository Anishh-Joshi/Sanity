import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/doctor_bloc/doctor_bloc.dart';
import 'package:sanity/model/doctor_model.dart';
import 'package:sanity/screens/doctor/doctor_profile.dart';
import 'package:sanity/widgets/cards/doctor_card.dart';
import 'package:sanity/widgets/circular_progress.dart';
import 'package:sanity/widgets/custom_appbar.dart';
class DoctorsPage extends StatelessWidget {
  static const String routeName = 'doctor_page';
  const DoctorsPage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute(
        builder: (context) => const DoctorsPage(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    context.read<DoctorBloc>().add(RetrieveDoctorsList());
    return Scaffold(
        appBar: MyCustomAppBar(
            elevation: 0,
            fontSize: 25,
            appBarTitle: '  Doctors',
            onPressed: () {}),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                BlocBuilder<DoctorBloc, DoctorState>(builder: (context, state) {
              if (state is DoctorListLoaded) {
                return ListView.builder(
                  shrinkWrap: true,
                  reverse: false,
                  itemCount: state.docList.length,
                  itemBuilder: (context, index) {
                    DoctorModel doc =
                        DoctorModel.fromJson(state.docList[index]);
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoctorProfile(
                                        url: doc.profileUrl,
                                        nmcId: doc.nmcId,
                                        profile: "General Doctor",
                                        name: doc.name,
                                        doctorId: doc.doctorId,
                                      )));
                        },
                        child: DoctorCard(
                            doctorName: doc.name,
                            gender: doc.gender,
                            location: doc.location,
                            profileUrl: doc.profileUrl,
                            nmcId: doc.nmcId,
                            hospitalName: "KMC"));
                  },
                );
              } else if (state is DoctorLoading) {
                return const Center(
                  child: CircularProgressIndicatorCustom(),
                );
              }
              return const Center(
                child: CircularProgressIndicatorCustom(),
              );
            }),
          ),
        ));
  }
}
