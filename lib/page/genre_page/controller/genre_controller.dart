import 'package:animeku_v2/model/genre_anime_model.dart';
import 'package:animeku_v2/service/api_service.dart';
import 'package:get/get.dart';

class GenreController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  final _isLoading = false.obs;
  final _genreListResponse = Rxn<GenreListResponse>();

  bool get isLoading => _isLoading.value;
  GenreListResponse? get genreListResponse => _genreListResponse.value;

  @override
  void onInit() {
    super.onInit();
    loadGenres();
  }

  Future<void> loadGenres() async {
    try {
      _isLoading.value = true;
      final data = await _apiService.getGenreList();
      _genreListResponse.value = data;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  void goToGenreAnime(String genreSlug, String genreName) {
    Get.toNamed('/genre-anime', parameters: {
      'slug': genreSlug,
      'name': genreName,
    });
  }
}

class GenreAnimeController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  final _isLoading = false.obs;
  final _isLoadingMore = false.obs;
  final _genreAnimeResponse = Rxn<GenreAnimeResponse>();
  final _allGenreAnime = <GenreAnime>[].obs;

  String genreSlug = '';
  String genreName = '';

  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
  GenreAnimeResponse? get genreAnimeResponse => _genreAnimeResponse.value;
  List<GenreAnime> get allGenreAnime => _allGenreAnime;

  @override
  void onInit() {
    super.onInit();
    genreSlug = Get.parameters['slug'] ?? '';
    genreName = Get.parameters['name'] ?? '';
    if (genreSlug.isNotEmpty) {
      loadGenreAnime();
    }
  }

  Future<void> loadGenreAnime([int page = 1]) async {
    try {
      if (page == 1) {
        _isLoading.value = true;
        _allGenreAnime.clear();
      } else {
        _isLoadingMore.value = true;
      }
      
      final data = await _apiService.getAnimeByGenre(genreSlug, page);
      _genreAnimeResponse.value = data;
      _allGenreAnime.addAll(data.anime);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _isLoading.value = false;
      _isLoadingMore.value = false;
    }
  }

  Future<void> loadNextPage() async {
    if (genreAnimeResponse?.paginationData.hasNextPage == true &&
        !isLoadingMore &&
        genreAnimeResponse?.paginationData.nextPage != null) {
      await loadGenreAnime(genreAnimeResponse!.paginationData.nextPage!);
    }
  }

  void goToAnimeDetail(String slug) {
    Get.toNamed('/detail', parameters: {'slug': slug});
  }

  Future<void> refresh() async {
    await loadGenreAnime(1);
  }
}