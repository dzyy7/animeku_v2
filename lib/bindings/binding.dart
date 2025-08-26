import 'package:animeku_v2/dashboard/dashboard_controller.dart';
import 'package:animeku_v2/page/anime_page/controller/home_controller.dart';
import 'package:animeku_v2/page/complete_anime_page/controller/complete_anime_controller.dart';
import 'package:animeku_v2/page/detail_anime_page/controller/detail_controller.dart';
import 'package:animeku_v2/page/genre_page/controller/genre_controller.dart';
import 'package:animeku_v2/page/schedule/controller/schedule_controller.dart';
import 'package:animeku_v2/page/video_page/controller/video_controller.dart';
import 'package:animeku_v2/service/api_service.dart';

import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Service
    Get.lazyPut<ApiService>(() => ApiService());
    
    // Controllers
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<DetailController>(() => DetailController());
    Get.lazyPut<VideoController>(() => VideoController());
    Get.lazyPut<ScheduleController>(() => ScheduleController());
    Get.lazyPut<CompleteAnimeController>(() => CompleteAnimeController());
    Get.lazyPut<GenreController>(() => GenreController());
    Get.lazyPut<GenreAnimeController>(() => GenreAnimeController());
  }
}