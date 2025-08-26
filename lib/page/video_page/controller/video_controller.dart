import 'package:animeku_v2/model/episode_detail_model.dart';
import 'package:animeku_v2/service/api_service.dart';
import 'package:get/get.dart';


class VideoController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  final _isLoading = false.obs;
  final _episodeDetail = Rxn<EpisodeDetailData>();

  bool get isLoading => _isLoading.value;
  EpisodeDetailData? get episodeDetail => _episodeDetail.value;

  @override
  void onInit() {
    super.onInit();
    final slug = Get.parameters['slug'];
    if (slug != null) {
      loadEpisodeDetail(slug);
    }
  }

  Future<void> loadEpisodeDetail(String slug) async {
    try {
      _isLoading.value = true;
      final data = await _apiService.getEpisodeDetail(slug);
      _episodeDetail.value = data;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  void goToNextEpisode() {
    if (episodeDetail?.hasNextEpisode == true && 
        episodeDetail?.nextEpisode != null) {
      Get.offNamed('/video', 
          parameters: {'slug': episodeDetail!.nextEpisode!.slug});
    }
  }

  void goToPreviousEpisode() {
    if (episodeDetail?.hasPreviousEpisode == true && 
        episodeDetail?.previousEpisode != null) {
      Get.offNamed('/video', 
          parameters: {'slug': episodeDetail!.previousEpisode!.slug});
    }
  }
}
