import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/feature/bockmark/views/pages/bockmark_page.dart';
import 'package:news_app/feature/home/views/home_page.dart';
import 'package:news_app/feature/profile/views/pages/profile_page.dart';
import 'package:news_app/feature/search/cubit/search_cubit.dart';
import 'package:news_app/feature/search/views/pages/search_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      stateManagement: false,
      tabs: [
        PersistentTabConfig(
          screen: HomePage(),
          item: ItemConfig(icon: Icon(Icons.home_outlined), title: "Home"),
        ),

        PersistentTabConfig(
          screen: BlocProvider(
            create: (context) => SearchCubit(),
            child: SearchPage(),
          ),

          item: ItemConfig(icon: Icon(Icons.search), title: "Search"),
        ),

        PersistentTabConfig(
          screen: BockmarkPage(),
          item: ItemConfig(
            icon: Icon(Icons.bookmark_outline),
            title: "Bookmark",
          ),
        ),

        PersistentTabConfig(
          screen: ProfilePage(),
          item: ItemConfig(icon: Icon(Icons.person_outlined), title: "Profile"),
        ),
      ],
      navBarBuilder:
          (navBarConfig) => Style8BottomNavBar(navBarConfig: navBarConfig),
    );
  }
}
