import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:sanity/widgets/cards/normal_card.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:sanity/widgets/custom_elevated_button.dart';

class DoctorProfile extends StatelessWidget {
  final String url;
  final String name;
  final String profile;
  final int nmcId;
  const DoctorProfile(
      {Key? key,
      required this.url,
      required this.name,
      required this.profile,
      required this.nmcId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
              child: SizedBox(
                height: height,
                width: width,
                child: LayoutBuilder(builder: (context, constraints) {
                  double innerHeight = constraints.maxHeight;
                  double innerWidth = constraints.maxWidth;
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.only(top: 80),
                          // height: innerHeight * 0.74,
                          width: innerWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [ 
                              Container(
                                height: height*0.15,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(flex: 1, child: Align(alignment: Alignment.centerRight, child: Container(width: 80, child: Text("Reputation on Sanity",style: Theme.of(context).textTheme.headline5,)))),
                                    Icon(Icons.diamond_rounded,size: height*0.15,color: Theme.of(context).primaryColor,),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("6",style: Theme.of(context).textTheme.headline5,),
                                            Text(
                                                "Top 0.9% of all professional help available in Sanity",style: Theme.of(context).textTheme.headline5),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                
                              ),
                              NormalCard(heading: "Tenure",text: "5 years",width: width,),
                              NormalCard(heading: "Education",text: "5 years",width: width,),
                              NormalCard(heading: "On Sanity",text: "5 years",width: width,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButtonCustom(action: (){}, color: Theme.of(context).primaryColor, buttonTitle: "Book An Appointment"),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Center(child: stackHeader(context, height, width)),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget stackHeader(BuildContext context, double height, double width) {
    return SizedBox(
      height: height * 0.8,
      width: width * 0.90,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double innerHeight = constraints.maxHeight;
            double innerWidth = constraints.maxWidth;
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: height * 0.15,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: innerHeight * 0.20,
                    width: innerWidth,
                    margin: const EdgeInsets.only(bottom: 7),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: kElevationToShadow[
                          2], // Use This kElevationToShadow ***********
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Dr. $name",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(fontSize: 20),
                          ),
                          Text(
                            profile,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontSize: 14),
                          ),
                          Text(
                            "NMC ID: $nmcId",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.05,
                  left: 0,
                  right: 0,
                  child: Center(
                      child: CircleAvatarCustom(
                    url: url,
                    radius: 60,
                  )),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget stackFooter(BuildContext context, double height, double width) {
    return Container(
      height: height * 0.6,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
    );
  }
}
