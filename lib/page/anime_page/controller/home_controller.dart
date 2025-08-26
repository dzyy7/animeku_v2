import 'package:animeku_v2/model/home_anime_model.dart';
import 'package:animeku_v2/page/anime_page/data/home_data.dart';
import 'package:get/get.dart';
import '../../../service/api_service.dart';


class HomeController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  final _isLoading = false.obs;
  final _homeData = Rxn<HomeData>();
  final _selectedTab = 0.obs;

  bool get isLoading => _isLoading.value;
  HomeData? get homeData => _homeData.value;
  int get selectedTab => _selectedTab.value;

  List<OngoingAnime> get ongoingAnime => homeData?.ongoingAnime ?? [];
  List<CompleteAnime> get completeAnime => homeData?.completeAnime ?? [];

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  void changeTab(int index) {
    _selectedTab.value = index;
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

  Future<void> refreshHomeData() async {
    await loadHomeData();
  }
}
