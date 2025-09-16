import 'dart:math';
import 'package:animeku_v2/model/search_page_model.dart';
import 'package:get/get.dart';
import 'package:animeku_v2/service/api_service.dart';
import '../data/home_data.dart';

class HomeController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  final _isLoading = false.obs;
  final _homeData = Rxn<HomeData>();
  final _carouselAnime = <UnlimitedAnime>[].obs;

  bool get isLoading => _isLoading.value;
  HomeData? get homeData => _homeData.value;
  List<UnlimitedAnime> get carouselAnime => _carouselAnime;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
    loadCarouselAnime();
  }

  Future<void> loadHomeData() async {
    try {
      _isLoading.value = true;
      final data = await _apiService.getHomeData();
      _homeData.value = data;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _isLoading.value = false;
    }
  }
  Future<String?> getPoster(String slug) async {
  try {
    final detail = await ApiService().getAnimeDetail(slug);
    return detail.poster;
  } catch (e) {
    return null;
  }
}


  Future<void> loadCarouselAnime() async {
    try {
      final response = await _apiService.getUnlimitedAnime();
      final allAnime = response.list.expand((group) => group.animeList).toList();

      if (allAnime.isNotEmpty) {
        allAnime.shuffle(Random());
        _carouselAnime.assignAll(allAnime.take(5).toList());
      }
    } catch (e) {
      print("Error load carousel: $e");
    }
  }

  void goToAnimeDetail(String slug) {
    Get.toNamed('/detail', parameters: {'slug': slug});
  }

  Future<void> refresh() async {
    await loadHomeData();
    await loadCarouselAnime();
  }
}
