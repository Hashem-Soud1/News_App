import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/model/NewsApiResponse.dart';
import 'package:news_app/core/utilities/app_constants.dart';
import 'package:news_app/feature/search/model/search_body.dart';
import 'package:news_app/feature/search/services/search_services.dart';
import 'package:news_app/feature/search/services/search_services_retrofit.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  // final searchServices = SearchServicesImpl();
  final searchServicesRetrofit = SearchServicesRetrofit(
    Dio(),
    baseUrl: AppConstants.baseUrl,
  );

  Future<void> search(String keyword) async {
    emit(Searching());
    try {
      final body = SearchBody(q: keyword);
      final response = await searchServicesRetrofit.getSearch(
        body.q!,
        body.page!,
        body.pageSize!,
        body.searchIn!,
        AppConstants.apiKey,
      );
      if (response.articles!.isEmpty) {
        emit(SearchError('No results found'));
      } else {
        emit(SearchLoaded(response.articles ?? []));
      }
    } catch (e) {
      emit(SearchError('Failed to load search results'));
    }
  }
}
