import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/model/article_model.dart';
import 'package:news_app/core/services/local_database_hive.dart';
import 'package:news_app/core/utilities/app_constants.dart';

part 'bookmark_actions_state.dart';

class BookmarkActionsCubit extends Cubit<BookmarkActionsState> {
  BookmarkActionsCubit._internal() : super(BookmarkActionsInitial());

  static final BookmarkActionsCubit _instance =
      BookmarkActionsCubit._internal();

  factory BookmarkActionsCubit() => _instance;

  final localDatabaseHive = LocalDatabaseHive();
  final Set<String> bookmarkedTitles = {};

  Future<void> setBookmark(Article article) async {
    emit(DoingBookmark(article.title ?? ''));
    try {
      final bookmarkArticles = await _getBookmark();
      final isFound = bookmarkArticles.any(
        (element) => element.title == article.title,
      );

      if (isFound) {
        final index = bookmarkArticles.indexWhere(
          (element) => element.title == article.title,
        );
        bookmarkArticles.removeAt(index);

        await localDatabaseHive.saveData<List<Article>>(
          AppConstants.bookmarksKey,
          bookmarkArticles,
        );

        bookmarkedTitles.remove(article.title);

        emit(BookmarkRemoved(article.title ?? ''));
      } else {
        bookmarkArticles.add(article);

        await localDatabaseHive.saveData<List<Article>>(
          AppConstants.bookmarksKey,
          bookmarkArticles,
        );

        bookmarkedTitles.add(article.title ?? '');

        emit(BookmarkAdded(article.title ?? ''));
      }
    } catch (e) {
      emit(DoingBookmarkError(e.toString(), article.title ?? ''));
    }
  }

  Future<List<Article>> _getBookmark() async {
    final bookmarkes = await localDatabaseHive.getData<List<dynamic>?>(
      AppConstants.bookmarksKey,
    );

    if (bookmarkes == null) {
      return [];
    }

    return bookmarkes.map((e) => e as Article).toList();
  }

  Future<void> loadInitialBookmarks() async {
    final bookmarkArticles = await _getBookmark();
    bookmarkedTitles
      ..clear()
      ..addAll(
        bookmarkArticles.map((e) => e.title ?? '').where((t) => t.isNotEmpty),
      );
  }
}
