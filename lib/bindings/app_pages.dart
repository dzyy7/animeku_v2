import 'package:animeku_v2/bindings/binding.dart';
import 'package:animeku_v2/dashboard/dashboard_page.dart';
import 'package:animeku_v2/page/detail_anime_page/menu/detail_page.dart';
import 'package:animeku_v2/page/genre_page/menu/genre_anime_page.dart';
import 'package:animeku_v2/page/search_page/menu/search_page.dart';

import 'package:animeku_v2/page/video_page/menu/video_page.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL = '/dashboard';

  static final routes = [
    GetPage(
      name: '/dashboard',
      page: () => DashboardPage(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: '/detail',
      page: () => DetailPage(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: '/video',
      page: () => VideoPage(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: '/genre-anime',
      page: () => GenreAnimePage(),
      binding: InitialBinding(),
    ),
    // GetPage(
    //   name: '/search',
    //   page: () => SearchPage(),
    //   binding: InitialBinding(),
    // ),
  ];
}