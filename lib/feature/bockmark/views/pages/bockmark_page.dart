import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/views/widgets/articel_widget_item.dart';
import 'package:news_app/feature/bockmark/cubit/bookmark_cubit.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    final favoritesCubit = BlocProvider.of<BookmarkCubit>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: BlocBuilder<BookmarkCubit, BookmarkState>(
        bloc: favoritesCubit,
        buildWhen:
            (previous, current) =>
                current is FavoritesLoading ||
                current is FavoritesLoaded ||
                current is FavoritesError,
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is FavoritesLoaded) {
            final articles = state.articles;

            if (articles.isEmpty) {
              return const Center(child: Text('No favorites yet!'));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                itemCount: articles.length,
                separatorBuilder:
                    (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(),
                    ),
                itemBuilder: (_, index) {
                  final article = articles[index];

                  return ArticleWidgetItem(
                    article: article,
                    isSmaller: true,
                    addEditeButton: true,
                  );
                },
              ),
            );
          } else if (state is FavoritesError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
