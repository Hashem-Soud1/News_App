import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/views/widgets/app_bar_button.dart';
import 'package:news_app/core/views/widgets/app_drawer.dart';
import 'package:news_app/feature/home/cubit/home_cubit.dart';
import 'package:news_app/feature/home/views/widget/custom_carousel_slider.dart';
import 'package:news_app/feature/home/views/widget/recommended_news.dart';
import 'package:news_app/feature/home/views/widget/title_headline_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocProvider(
      create:
          (context) =>
              HomeCubit()
                ..getTopHeadlines()
                ..getRecommendationNews(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppBarButton(
              iconData: Icons.menu,
              onTap: () {
                scaffoldKey.currentState!.openDrawer();
              },
            ),
          ),
          actions: [
            AppBarButton(
              iconData: Icons.nightlight_outlined,
              hasPaddingBetween: true,
              onTap: () {},
            ),
            const SizedBox(width: 8),
            AppBarButton(
              iconData: Icons.notifications_none_rounded,
              hasPaddingBetween: true,
              onTap: () {},
            ),
            const SizedBox(width: 12),
          ],
        ),
        drawer: const AppDrawer(),
        body: SafeArea(
          child: Builder(
            builder: (context) {
              final homeCubit = BlocProvider.of<HomeCubit>(context);

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      TitleHeadlineWidget(title: 'Breaking News', onTap: () {}),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 220,
                        child: BlocBuilder<HomeCubit, HomeState>(
                          bloc: homeCubit,
                          buildWhen:
                              (previous, current) =>
                                  current is TopHeadlinesLoading ||
                                  current is TopHeadlinesLoaded ||
                                  current is TopHeadlinesError,
                          builder: (context, state) {
                            if (state is TopHeadlinesLoading) {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            } else if (state is TopHeadlinesLoaded) {
                              final articles = state.articles;
                              return CustomCarouselSlider(
                                articles: articles ?? [],
                              );
                            } else if (state is TopHeadlinesError) {
                              return Center(child: Text(state.message));
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      TitleHeadlineWidget(
                        title: 'Recommendation',
                        onTap: () {},
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<HomeCubit, HomeState>(
                        bloc: homeCubit,
                        buildWhen:
                            (previous, current) =>
                                current is RecommendedNewsLoading ||
                                current is RecommendedNewsLoaded ||
                                current is RecommendedNewsError,
                        builder: (context, state) {
                          if (state is RecommendedNewsLoading) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          } else if (state is RecommendedNewsLoaded) {
                            final articles = state.articles;
                            return RecommendedNewsWidget(
                              articles: articles ?? [],
                            );
                          } else if (state is RecommendedNewsError) {
                            return Center(child: Text(state.message));
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
