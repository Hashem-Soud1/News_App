part of 'bookmark_actions_cubit.dart';

sealed class BookmarkActionsState {
  const BookmarkActionsState();
}

final class BookmarkActionsInitial extends BookmarkActionsState {}

final class DoingBookmark extends BookmarkActionsState {
  final String title;

  const DoingBookmark(this.title);
}

final class BookmarkAdded extends BookmarkActionsState {
  final String title;

  const BookmarkAdded(this.title);
}

final class BookmarkRemoved extends BookmarkActionsState {
  final String title;

  const BookmarkRemoved(this.title);
}

final class DoingBookmarkError extends BookmarkActionsState {
  final String message;
  final String title;

  const DoingBookmarkError(this.message, this.title);
}
