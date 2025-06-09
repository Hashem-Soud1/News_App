import 'package:flutter/material.dart';
import 'package:news_app/core/model/article_model.dart';
import 'package:news_app/core/views/widgets/articel_widget_item.dart';

class RecommendedNewsWidget extends StatelessWidget {
  final List<Article> articles;
  const RecommendedNewsWidget({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: articles.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final article = articles[index];

        return ArticleWidgetItem(article: article, isSmaller: true);
      },
    );
  }
}
