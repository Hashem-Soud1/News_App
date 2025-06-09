part of 'bookmark_cubit.dart';

sealed class BookmarkState {
  const BookmarkState();
}

final class BookmarkesInitial extends BookmarkState {}

final class FavoritesLoading extends BookmarkState {}

final class FavoritesLoaded extends BookmarkState {
  final List<Article> articles;

  const FavoritesLoaded(this.articles);
}

final class FavoritesError extends BookmarkState {
  final String message;

  const FavoritesError(this.message);
}
