import 'package:dio/dio.dart';
import 'package:news_app/core/utilities/app_constants.dart';
import 'package:news_app/core/model/NewsApiResponse.dart';
import 'package:news_app/feature/search/model/search_body.dart';

abstract class SearchServices {
  Future<NewsApiResponse> getSearch(SearchBody body);
}

class SearchServicesImpl implements SearchServices {
  final aDio = Dio();
  @override
  Future<NewsApiResponse> getSearch(SearchBody body) async {
    try {
      aDio.options.baseUrl = 'https://newsapi.org';
      final headers = {'Authorization': 'Bearer ${AppConstants.apiKey}'};
      final response = await aDio.get(
        AppConstants.everything,
        queryParameters: body.toMap(),
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return NewsApiResponse.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to load search results: ${response.statusMessage}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
