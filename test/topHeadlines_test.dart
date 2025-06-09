import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app/feature/home/model/TopHeadlinesBody.dart';
import 'package:news_app/feature/home/servicse/home_services.dart';

import 'topHeadlines_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late HomeServicesImpl homeServices;

  setUp(() {
    mockDio = MockDio();
    when(mockDio.options).thenReturn(BaseOptions());

    homeServices = HomeServicesImpl(dio: mockDio);
  });

  test('should return valid response when status code is 200', () async {
    final body = TopHeadlinesBody(country: 'us', category: 'business');

    final mockResponseData = {
      "status": "ok",
      "totalResults": 1,
      "articles": [
        {
          "title": "Test Article",
          "description": "Description",
          "url": "https://example.com",
          "urlToImage": "https://example.com/image.jpg",
          "publishedAt": "2024-06-12T10:00:00Z",
        },
      ],
    };

    when(
      mockDio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
      ),
    ).thenAnswer(
      (_) async => Response(
        data: mockResponseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final result = await homeServices.getTopHeadlines(body);

    expect(result.status, 'ok');
  });

  test('should throw exception when status code is not 200', () async {
    final body = TopHeadlinesBody(country: 'us', category: 'business');

    when(
      mockDio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
      ),
    ).thenAnswer(
      (_) async => Response(
        data: null,
        statusCode: 404,
        statusMessage: "Not Found",
        requestOptions: RequestOptions(path: ''),
      ),
    );

    expect(() => homeServices.getTopHeadlines(body), throwsException);
  });
}
