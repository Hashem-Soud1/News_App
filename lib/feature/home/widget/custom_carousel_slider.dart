import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/route/app_routes.dart';
import 'package:news_app/core/utilities/theme/app_colors.dart';
import 'package:news_app/core/model/NewsApiResponse.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<Article> articles;
  const CustomCarouselSlider({super.key, required this.articles});

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders =
        widget.articles.map((item) {
          final parsedDate = DateTime.parse(
            item.publishedAt ?? DateTime.now().toString(),
          );
          final publishedDate = DateFormat.yMMMd().format(parsedDate);
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.articleDetails,
                arguments: item,
              );
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              child: Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl:
                        item.urlToImage ??
                        'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
                    fit: BoxFit.cover,
                    width: 1000.0,
                    height: 220,
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item.source?.name ?? ''} . $publishedDate',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          Text(
                            item.title ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList();

    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
              viewportFraction: 0.84,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.1,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              widget.articles.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: _current == entry.key ? 22.0 : 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 4.0,
                    ),

                    decoration: BoxDecoration(
                      borderRadius:
                          _current == entry.key
                              ? const BorderRadius.all(Radius.circular(5))
                              : null,
                      shape:
                          _current == entry.key
                              ? BoxShape.rectangle
                              : BoxShape.circle,
                      color:
                          _current == entry.key
                              ? AppColors.primary.withOpacity(0.5)
                              : AppColors.black.withOpacity(0.2),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
