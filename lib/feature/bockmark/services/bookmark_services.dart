import 'package:news_app/core/model/article_model.dart';
import 'package:news_app/core/services/local_database_hive.dart';
import 'package:news_app/core/utilities/app_constants.dart';

class FavoritesServices {
  final localDatabaseHive = LocalDatabaseHive();

  Future<List<Article>> getFavoritesHive() async {
    final favorites = await localDatabaseHive.getData<List<dynamic>?>(
      AppConstants.bookmarksKey,
    );

    if (favorites == null) {
      return [];
    }
    return favorites.map((e) => e as Article).toList();
  }
}
