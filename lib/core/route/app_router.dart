import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/route/app_routes.dart';
import 'package:news_app/core/model/NewsApiResponse.dart';
import 'package:news_app/feature/home/views/article_details_page.dart';
import 'package:news_app/feature/home/views/home_page.dart';
import 'package:news_app/feature/search/cubit/search_cubit.dart';
import 'package:news_app/feature/search/views/pages/search_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );

      case AppRoutes.articleDetails:
        final article = settings.arguments as Article;
        return MaterialPageRoute(
          builder: (_) => ArticleDetailsPage(article: article),
          settings: settings,
        );

      case AppRoutes.search:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => SearchCubit(),
                child: const SearchPage(),
              ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
          settings: settings,
        );
    }
  }
}
