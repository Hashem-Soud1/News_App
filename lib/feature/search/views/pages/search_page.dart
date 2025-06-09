import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/views/widgets/articel_widget_item.dart';
import 'package:news_app/feature/search/cubit/search_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchCubit = BlocProvider.of<SearchCubit>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by title',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: BlocBuilder<SearchCubit, SearchState>(
                  bloc: searchCubit,
                  buildWhen:
                      (previous, current) =>
                          current is Searching ||
                          current is SearchLoaded ||
                          current is SearchError,
                  builder: (context, state) {
                    if (state is Searching) {
                      return const TextButton(
                        onPressed: null,
                        child: Text('Search'),
                      );
                    }
                    return TextButton(
                      onPressed:
                          () async =>
                              await searchCubit.search(_searchController.text),
                      child: const Text('Search'),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                bloc: searchCubit,
                buildWhen:
                    (previous, current) =>
                        current is Searching ||
                        current is SearchLoaded ||
                        current is SearchError,
                builder: (context, state) {
                  if (state is Searching) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is SearchLoaded) {
                    final articles = state.article;
                    if (articles.isEmpty) {
                      return const Center(child: Text('No articles found'));
                    }
                    return ListView.separated(
                      itemCount: articles.length,
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 10),
                      itemBuilder: (_, index) {
                        final article = articles[index];
                        return ArticleWidgetItem(
                          article: article,
                          isSmaller: true,
                        );
                      },
                    );
                  } else if (state is SearchError) {
                    return Center(child: Text(state.error));
                  } else {
                    return const Center(child: Text('Search for articles'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
