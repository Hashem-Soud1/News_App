import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/model/article_model.dart';
import 'package:news_app/core/route/app_routes.dart';
import 'package:news_app/core/utilities/theme/app_colors.dart';

class ArticleWidgetItem extends StatelessWidget {
  final Article article;
  final bool isSmaller;
  final bool addEditeButton;
  final VoidCallback? onDelete;

  const ArticleWidgetItem({
    super.key,
    required this.article,
    this.isSmaller = false,
    this.addEditeButton = false,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final parsedDate =
        DateTime.tryParse(article.publishedAt ?? '') ?? DateTime.now();
    final formattedDate = DateFormat.yMMMd().format(parsedDate);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap:
                () => Navigator.of(
                  context,
                ).pushNamed(AppRoutes.articleDetails, arguments: article),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl:
                        article.urlToImage ??
                        'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
                    width: isSmaller ? 120 : 170,
                    height: isSmaller ? 130 : 180,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge!.copyWith(color: AppColors.grey),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        article.title ?? '',
                        maxLines: isSmaller ? 2 : 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        article.source?.name ?? '',
                        style: Theme.of(context).textTheme.labelLarge,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (addEditeButton)
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
      ],
    );
  }
}
