// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoaded extends SearchState {
  final SearchEntity search;
  const SearchLoaded({
    required this.search,
  });
}

class SearchError extends SearchState {
  final String msg;
  const SearchError({
    required this.msg,
  });
}

class SearchLoading extends SearchState {}
