import 'package:animeku_v2/page/detail_anime_page/controller/detail_controller.dart';
import 'package:get/get.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies()  {
    Get.lazyPut<DetailController>(() => DetailController());
  }
}
