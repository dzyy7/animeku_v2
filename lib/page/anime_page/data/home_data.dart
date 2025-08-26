import 'package:animeku_v2/model/home_anime_model.dart';

class HomeData {
  final List<OngoingAnime> ongoingAnime;
  final List<CompleteAnime> completeAnime;

  HomeData({
    required this.ongoingAnime,
    required this.completeAnime,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      ongoingAnime: (json['ongoing_anime'] as List)
          .where((item) => item != null && item.isNotEmpty)
          .map((item) => OngoingAnime.fromJson(item))
          .toList(),
      completeAnime: (json['complete_anime'] as List)
          .where((item) => item != null && item.isNotEmpty)
          .map((item) => CompleteAnime.fromJson(item))
          .toList(),
    );
  }
}
