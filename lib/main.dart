import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/cubit/bookmark_actions_cubit.dart';
import 'package:news_app/core/route/app_router.dart';
import 'package:news_app/core/route/app_routes.dart';
import 'package:news_app/core/services/local_database_hive.dart';

import 'package:news_app/core/utilities/app_constants.dart';
import 'package:news_app/core/utilities/theme/app_theme.dart';

void main() {
  LocalDatabaseHive.initHive();
  BookmarkActionsCubit().loadInitialBookmarks();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<BookmarkActionsCubit>(
          create: (_) => BookmarkActionsCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.mainTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRoutes.home,
    );
  }
}
