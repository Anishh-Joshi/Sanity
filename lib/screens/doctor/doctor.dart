import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/doctor_bloc/doctor_bloc.dart';
import 'package:sanity/model/doctor_model.dart';
import 'package:sanity/screens/doctor/doctor_profile.dart';
import 'package:sanity/widgets/cards/doctor_card.dart';
import 'package:sanity/widgets/custom_appbar.dart';

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<DoctorBloc>().add(RetrieveDoctorsList());
    return  Scaffold(
      appBar: const MyCustomAppBar(appBarTitle: 'Doctors Near You'),
      body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<DoctorBloc,DoctorState>(
          builder: (context,state){
            if(state is DoctorListLoaded){
              return ListView.builder(
                reverse: false,
                itemCount: state.docList.length,
                itemBuilder: (context,index){
                  DoctorModel doc = DoctorModel.fromJson(state.docList[index]);
                  return GestureDetector(
                                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorProfile(url: doc.profileUrl,nmcId: doc.nmcId, profile: "General Doctor",name: doc.name,)));
                },
                    child: DoctorCard(doctorName:doc.name , gender: doc.gender, location: doc.location, profileUrl: doc.profileUrl, nmcId: doc.nmcId, hospitalName: "KMC"));
              
                },
                 );
            }
            else if(state is DoctorLoading){
              return const Center(child: CircularProgressIndicator(),);
            }
            return const Center(child: CircularProgressIndicator(),);
          }
          ),
        ),
    ));
  }
}
