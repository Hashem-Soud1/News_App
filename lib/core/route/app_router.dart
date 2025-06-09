import 'package:flutter/material.dart';
import 'package:news_app/core/model/article_model.dart';
import 'package:news_app/core/route/app_routes.dart';
import 'package:news_app/core/views/bottom_nav.dart';
import 'package:news_app/feature/home/views/pages/article_details_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => CustomBottomNavbar());

      case AppRoutes.articleDetails:
        final article = settings.arguments as Article;
        return MaterialPageRoute(
          builder: (_) => ArticleDetailsPage(article: article),
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
