import 'package:animeku_v2/bindings/detail_binding.dart';
import 'package:animeku_v2/bindings/home_binding.dart';
import 'package:animeku_v2/bindings/video_binding.dart';
import 'package:animeku_v2/page/anime_page/menu/home_page.dart';
import 'package:animeku_v2/page/detail_anime_page/menu/detail_page.dart';
import 'package:animeku_v2/page/video_page/menu/video_page.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO,
      page: () => VideoPlayerView(),
      binding: VideoBinding(),
    ),
  ];
}
