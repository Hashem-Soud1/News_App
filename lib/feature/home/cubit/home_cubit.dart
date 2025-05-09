import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/feature/home/model/TopHeadlinesBody.dart';
import 'package:news_app/feature/home/model/TopHeadlinesResponse%20.dart';
import 'package:news_app/feature/home/servicse/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final homeService = HomeServicesImpl();
  void getTopHeadlines() async {
    emit(TopHeadlinesLoading());

    try {
      final response = TopHeadlinesBody(
        country: 'us',
        category: 'business',
        pageSize: 7,
        page: 1,
      );
      final result = await homeService.getTopHeadlines(response);

      emit(TopHeadlinesLoaded(result.articles));
    } catch (e) {
      emit(TopHeadlinesError('Failed to load headlines'));
    }
  }
}
