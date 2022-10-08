import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchLoaded(query: "")) {
    on<InitiateSearch>(_search);
  }

  void _search (InitiateSearch event, Emitter<SearchState> emit)async{
  
    if(this.state is SearchLoaded){
      final state = this.state as SearchLoaded;
      emit(SearchLoaded(query:  event.query));
    }

  }


}
