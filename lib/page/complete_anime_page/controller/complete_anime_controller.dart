import 'package:animeku_v2/service/api_service.dart';
import 'package:get/get.dart';

import '../../../model/completed_anime_model.dart';

class CompleteAnimeController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  final _isLoading = false.obs;
  final _isLoadingMore = false.obs;
  final _completeAnimeResponse = Rxn<CompleteAnimeResponse>();
  final _allCompleteAnime = <CompleteAnimeData>[].obs;

  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
  CompleteAnimeResponse? get completeAnimeResponse => _completeAnimeResponse.value;
  List<CompleteAnimeData> get allCompleteAnime => _allCompleteAnime;

  @override
  void onInit() {
    super.onInit();
    loadCompleteAnime();
  }

  Future<void> loadCompleteAnime([int page = 1]) async {
    try {
      if (page == 1) {
        _isLoading.value = true;
        _allCompleteAnime.clear();
      } else {
        _isLoadingMore.value = true;
      }
      
      final data = await _apiService.getCompleteAnime(page);
      _completeAnimeResponse.value = data;
      _allCompleteAnime.addAll(data.completeAnimeData);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _isLoading.value = false;
      _isLoadingMore.value = false;
    }
  }

  Future<void> loadNextPage() async {
    if (completeAnimeResponse?.paginationData.hasNextPage == true &&
        !isLoadingMore &&
        completeAnimeResponse?.paginationData.nextPage != null) {
      await loadCompleteAnime(completeAnimeResponse!.paginationData.nextPage!);
    }
  }

  void goToAnimeDetail(String slug) {
    Get.toNamed('/detail', parameters: {'slug': slug});
  }

  Future<void> refresh() async {
    await loadCompleteAnime(1);
  }
}