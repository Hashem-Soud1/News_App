import 'package:dio/dio.dart';
import 'package:news_app/core/model/NewsApiResponse.dart';
import 'package:news_app/core/utilities/app_constants.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'search_services_retrofit.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class SearchServicesRetrofit {
  factory SearchServicesRetrofit(Dio dio, {String baseUrl}) =
      _SearchServicesRetrofit;

  @GET(AppConstants.everything)
  Future<NewsApiResponse> getSearch(
    @Query('q') String query,
    @Query('page') int page,
    @Query('pageSize') int pageSize,
    @Query('searchIn') String searchIn,
    @Header('Authorization') String apiKey,
  );
}
