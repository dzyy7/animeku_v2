import 'package:animeku_v2/page/anime_page/controller/home_controller.dart';
import 'package:animeku_v2/service/api_service.dart';
import 'package:get/get.dart';


class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiService(), permanent: true);
    Get.put(HomeController());
  }
}
