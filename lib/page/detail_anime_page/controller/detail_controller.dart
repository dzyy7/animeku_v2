import 'package:animeku_v2/model/anime_detail_model.dart';
import 'package:animeku_v2/service/api_service.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  final _isLoading = false.obs;
  final _animeDetail = Rxn<AnimeDetail>();
  final _displayedEpisodesCount = 10.obs;
  static const int _episodesPerPage = 10;

  bool get isLoading => _isLoading.value;
  AnimeDetail? get animeDetail => _animeDetail.value;
  int get displayedEpisodesCount => _displayedEpisodesCount.value;
  
  List<Episode> get displayedEpisodes {
    if (_animeDetail.value == null) return [];
    final episodes = _animeDetail.value!.episodeLists;
    return episodes.take(_displayedEpisodesCount.value).toList();
  }
  
  bool get canLoadMoreEpisodes {
    if (_animeDetail.value == null) return false;
    return _displayedEpisodesCount.value < _animeDetail.value!.episodeLists.length;
  }
  
  int get remainingEpisodesCount {
    if (_animeDetail.value == null) return 0;
    return _animeDetail.value!.episodeLists.length - _displayedEpisodesCount.value;
  }

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
      // Reset displayed episodes count when loading new anime
      _displayedEpisodesCount.value = _episodesPerPage;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  void loadMoreEpisodes() {
    if (canLoadMoreEpisodes) {
      _displayedEpisodesCount.value += _episodesPerPage;
    }
  }
  
  void showAllEpisodes() {
    if (_animeDetail.value != null) {
      _displayedEpisodesCount.value = _animeDetail.value!.episodeLists.length;
    }
  }

  void watchEpisode(String episodeSlug) {
    Get.toNamed('/video', parameters: {'slug': episodeSlug});
  }
}