part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class InitiateSearch extends SearchEvent{
   final String query;

  const InitiateSearch({required this.query});

   @override
  List<Object> get props => [query];

}
