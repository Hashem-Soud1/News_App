import 'package:news_app/core/theme/app_constants.dart';
import 'package:news_app/feature/home/model/TopHeadlinesBody.dart';
import 'package:dio/dio.dart';
import 'package:news_app/feature/home/model/TopHeadlinesResponse%20.dart';

abstract class HomeServices {
  Future<TopHeadlinesApiResponse> getTopHeadlines(TopHeadlinesBody body);
}

class HomeServicesImpl implements HomeServices {
  final aDio = Dio();

  @override
  Future<TopHeadlinesApiResponse> getTopHeadlines(TopHeadlinesBody body) async {
    try {
      aDio.options.baseUrl = AppConstants.baseUrl;
      final headers = {'Authorization': 'Bearer ${AppConstants.apiKey}'};
      final response = await aDio.get(
        AppConstants.topHeadlines,
        queryParameters: body.toMap(),
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return TopHeadlinesApiResponse.fromMap(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      rethrow;
    }
  }
}
