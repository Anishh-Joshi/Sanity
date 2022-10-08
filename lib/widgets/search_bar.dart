import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/search_bloc/search_bloc.dart';
import 'custom_form.dart';

class SearchTherapy extends StatefulWidget {
  const SearchTherapy({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchTherapy> createState() => _SearchTherapyState();
}

class _SearchTherapyState extends State<SearchTherapy> {
  TextEditingController searchController = TextEditingController(text: "");
  @override
  void initState() {
    super.initState();
    searchController.addListener(() => {
          context
              .read<SearchBloc>()
              .add(InitiateSearch(query: searchController.text.toLowerCase()))
        });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoaded) {
          return Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomForm(
                controller: searchController,
                iconDataSuffix: Icons.clear_rounded,
                hintText:state.query==""? "Therapies Eg:Anxeity":state.query ,
                containerColor: Theme.of(context).cardColor,
                iconColor: Theme.of(context).canvasColor,
                suffixIconPressed: () {
                  searchController.clear();
                  context
                      .read<SearchBloc>()
                      .add(const InitiateSearch(query: ""));
                },
                keyboardType: TextInputType.text,
                borderColor: Colors.transparent,
                iconData: Icons.search,
                borderRadius: 20,
              ));
        }
        return const SizedBox();
      },
    );
  }
}
