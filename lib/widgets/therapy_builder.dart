import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanity/blocs/search_bloc/search_bloc.dart';
import 'package:sanity/model/therapy_model.dart';
import 'package:sanity/widgets/home_card.dart';
import '../blocs/therapy/therapy_bloc.dart';
import '../screens/therapy/therapy.dart';

class TherapyBuilder extends StatelessWidget {
  final bool allView;
  const TherapyBuilder({Key? key, required this.allView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TherapyBloc, TherapyState>(
      builder: (context, state) {
        if (state is TherapyLoaded) {
          return SizedBox(
            height: allView
                ? MediaQuery.of(context).size.height * 0.65
                : MediaQuery.of(context).size.height / 4,
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, st) {
                if(st is SearchLoaded){
                  return ListView.builder(
                    physics: allView? NeverScrollableScrollPhysics():AlwaysScrollableScrollPhysics(),
                    scrollDirection: allView ? Axis.vertical : Axis.horizontal,
                    itemCount: allView
                        ? state.therapyList!.length
                        : state.therapyList!.length > 10
                            ? 10
                            : state.therapyList!.length,
                    itemBuilder: (context, index) {
                      final TherapyModel therapy = TherapyModel.fromJSON(
                          state.therapyList![index],
                          state.emoteMap!,
                          state.byDoctor[index]);
                      return therapy.title!.toLowerCase().contains(st.query)
                          ? InkWell(
                              onTap: () {
                                context.read<TherapyBloc>().add(
                                    GetTherapyDetails(
                                        byDoctor: state.byDoctor,
                                        therapyId: therapy.therapyId!,
                                        emoteMap: state.emoteMap,
                                        therapyList: state.therapyList));

                                Navigator.pushNamed(
                                  context,
                                  Therapy.routeName,
                                  arguments: therapy,
                                );
                              },
                              child: TherapyCard(
                                therapy: therapy,
                              ),
                            )
                          : const SizedBox();
                    });
                }
                return const SizedBox();
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
