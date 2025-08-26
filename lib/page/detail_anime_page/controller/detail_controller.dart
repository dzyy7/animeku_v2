import 'package:animeku_v2/model/anime_detail_model.dart';
import 'package:animeku_v2/service/api_service.dart';
import 'package:get/get.dart';


class DetailController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  final _isLoading = false.obs;
  final _animeDetail = Rxn<AnimeDetail>();

  bool get isLoading => _isLoading.value;
  AnimeDetail? get animeDetail => _animeDetail.value;

  @override
  void onInit() {
    super.onInit();
    final slug = Get.parameters['slug'];
    if (slug != null) {
      loadAnimeDetail(slug);
    }
  }

  Future<void> loadAnimeDetail(String slug) async {
    try {
      _isLoading.value = true;
      final data = await _apiService.getAnimeDetail(slug);
      _animeDetail.value = data;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  void watchEpisode(String episodeSlug) {
    Get.toNamed('/video', parameters: {'slug': episodeSlug});
  }
}
