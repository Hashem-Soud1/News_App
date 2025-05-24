part of 'search_cubit.dart';

sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class Searching extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<Article> article;

  SearchLoaded(this.article);
}

final class SearchError extends SearchState {
  final String error;

  SearchError(this.error);
}
