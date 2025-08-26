class ScheduleAnime {
  final String animeName;
  final String url;
  final String slug;

  ScheduleAnime({
    required this.animeName,
    required this.url,
    required this.slug,
  });

  factory ScheduleAnime.fromJson(Map<String, dynamic> json) {
    return ScheduleAnime(
      animeName: json['anime_name'] ?? '',
      url: json['url'] ?? '',
      slug: json['slug'] ?? '',
    );
  }
}

class DaySchedule {
  final String day;
  final List<ScheduleAnime> animeList;

  DaySchedule({
    required this.day,
    required this.animeList,
  });

  factory DaySchedule.fromJson(Map<String, dynamic> json) {
    return DaySchedule(
      day: json['day'] ?? '',
      animeList: (json['anime_list'] as List)
          .map((item) => ScheduleAnime.fromJson(item))
          .toList(),
    );
  }
}

class ScheduleData {
  final List<DaySchedule> schedules;

  ScheduleData({
    required this.schedules,
  });

  factory ScheduleData.fromJson(List<dynamic> json) {
    return ScheduleData(
      schedules: json.map((item) => DaySchedule.fromJson(item)).toList(),
    );
  }
}