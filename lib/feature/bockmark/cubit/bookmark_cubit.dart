import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/cubit/bookmark_actions_cubit.dart';
import 'package:news_app/feature/bockmark/services/bookmark_services.dart';
import 'package:news_app/core/model/article_model.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkesInitial()) {
    favoriteActionsCubit.stream.listen((state) {
      if (state is BookmarkRemoved) {
        getFavoriteItems();
      }
    });
  }

  final favoritesServices = FavoritesServices();
  final favoriteActionsCubit = BookmarkActionsCubit();

  Future<void> getFavoriteItems() async {
    emit(FavoritesLoading());
    try {
      final favArticles = await favoritesServices.getFavoritesHive();
      for (int index = 0; index < favArticles.length; index++) {
        var article = favArticles[index];
        article = article.copyWith(isFavorite: true);
        favArticles[index] = article;
      }
      emit(FavoritesLoaded(favArticles));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
