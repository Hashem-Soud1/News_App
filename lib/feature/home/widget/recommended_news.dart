import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/route/app_routes.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/feature/home/model/TopHeadlinesResponse%20.dart';

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
        final parsedDate = DateTime.parse(article.publishedAt!);
        final formattedDate = DateFormat().add_yMMMd().format(parsedDate);

        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.articleDetails,
              arguments: article,
            );
          },
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl:
                      article.urlToImage ??
                      'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
                  width: 150,
                  height: 150,
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
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      article.source?.name ?? '',
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge!.copyWith(color: AppColors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
