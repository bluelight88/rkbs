part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final HomeObj searchResponseModel;

  const SearchSuccess(this.searchResponseModel);
}

final class SearchFailure extends SearchState {
  final String message;

  const SearchFailure(this.message);
}
