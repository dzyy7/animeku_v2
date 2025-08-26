import 'package:animeku_v2/model/schedule_anime_model.dart';
import 'package:animeku_v2/service/api_service.dart';
import 'package:get/get.dart';

class ScheduleController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  final _isLoading = false.obs;
  final _scheduleData = Rxn<ScheduleData>();

  bool get isLoading => _isLoading.value;
  ScheduleData? get scheduleData => _scheduleData.value;

  @override
  void onInit() {
    super.onInit();
    loadSchedule();
  }

  Future<void> loadSchedule() async {
    try {
      _isLoading.value = true;
      final data = await _apiService.getSchedule();
      _scheduleData.value = data;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  void goToAnimeDetail(String slug) {
    Get.toNamed('/detail', parameters: {'slug': slug});
  }
}