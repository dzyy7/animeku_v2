// lib/page/search_page/controller/search_controller.dart

import 'package:animeku_v2/model/search_page_model.dart';
import 'package:animeku_v2/service/api_service.dart';
import 'package:get/get.dart';
import 'dart:async';

class AnimeSearchController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  final _isLoadingUnlimited = false.obs;
  final _isLoadingSearch = false.obs;
  final _unlimitedAnime = Rxn<UnlimitedAnimeResponse>();
  final _searchResults = <SearchAnimeResult>[].obs;
  final _filteredUnlimitedAnime = <UnlimitedAnime>[].obs;
  final _searchKeyword = ''.obs;
  final _selectedCharacter = 'All'.obs;
  
  Timer? _debounceTimer;
  static const Duration _debounceDuration = Duration(milliseconds: 500);

  bool get isLoadingUnlimited => _isLoadingUnlimited.value;
  bool get isLoadingSearch => _isLoadingSearch.value;
  UnlimitedAnimeResponse? get unlimitedAnime => _unlimitedAnime.value;
  List<SearchAnimeResult> get searchResults => _searchResults;
  List<UnlimitedAnime> get filteredUnlimitedAnime => _filteredUnlimitedAnime;
  String get searchKeyword => _searchKeyword.value;
  String get selectedCharacter => _selectedCharacter.value;
  
  bool get hasSearchResults => _searchResults.isNotEmpty;
  bool get isSearching => _searchKeyword.value.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    loadUnlimitedAnime();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }

  Future<void> loadUnlimitedAnime() async {
    try {
      _isLoadingUnlimited.value = true;
      final data = await _apiService.getUnlimitedAnime();
      _unlimitedAnime.value = data;
      _filterUnlimitedAnime();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _isLoadingUnlimited.value = false;
    }
  }

  void onSearchChanged(String keyword) {
    _searchKeyword.value = keyword;
    
    // Cancel previous timer
    _debounceTimer?.cancel();
    
    if (keyword.isEmpty) {
      _searchResults.clear();
      _filterUnlimitedAnime();
      return;
    }

    // Set new timer
    _debounceTimer = Timer(_debounceDuration, () {
      if (keyword.length >= 2) {
        searchAnime(keyword);
      }
    });
  }

  Future<void> searchAnime(String keyword) async {
    if (keyword.trim().isEmpty) return;
    
    try {
      _isLoadingSearch.value = true;
      final results = await _apiService.searchAnime(keyword.trim());
      _searchResults.value = results.data;
    } catch (e) {
      Get.snackbar('Error', 'Failed to search anime: ${e.toString()}');
      _searchResults.clear();
    } finally {
      _isLoadingSearch.value = false;
    }
  }

  void selectCharacter(String character) {
    _selectedCharacter.value = character;
    _filterUnlimitedAnime();
  }

  void _filterUnlimitedAnime() {
    if (_unlimitedAnime.value == null) return;

    List<UnlimitedAnime> allAnime = [];
    
    // Flatten all anime from all groups
    for (final group in _unlimitedAnime.value!.list) {
      allAnime.addAll(group.animeList);
    }

    if (_selectedCharacter.value == 'All') {
      _filteredUnlimitedAnime.value = allAnime;
    } else {
      final selectedGroup = _unlimitedAnime.value!.list.firstWhereOrNull(
        (group) => group.startWith == _selectedCharacter.value,
      );
      _filteredUnlimitedAnime.value = selectedGroup?.animeList ?? [];
    }
  }

  List<String> get availableCharacters {
    if (_unlimitedAnime.value == null) return ['All'];
    
    List<String> characters = ['All'];
    characters.addAll(
      _unlimitedAnime.value!.list.map((group) => group.startWith)
    );
    return characters;
  }

  void goToAnimeDetail(String slug) {
    Get.toNamed('/detail', parameters: {'slug': slug});
  }

  void clearSearch() {
    _searchKeyword.value = '';
    _searchResults.clear();
    _filterUnlimitedAnime();
  }

  Future<void> refresh() async {
    await loadUnlimitedAnime();
  }
}