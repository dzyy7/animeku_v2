class OngoingAnime {
  final String title;
  final String slug;
  final String poster;
  final String currentEpisode;
  final String releaseDay;
  final String newestReleaseDate;
  final String otakudesuUrl;
  OngoingAnime({
    required this.title,
    required this.slug,
    required this.poster,
    required this.currentEpisode,
    required this.releaseDay,
    required this.newestReleaseDate,
    required this.otakudesuUrl,
  });

  factory OngoingAnime.fromJson(Map<String, dynamic> json) {
    return OngoingAnime(
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      poster: json['poster'] ?? '',
      currentEpisode: json['current_episode'] ?? '',
      releaseDay: json['release_day'] ?? '',
      newestReleaseDate: json['newest_release_date'] ?? '',
      otakudesuUrl: json['otakudesu_url'] ?? '',
    );
  }
}

class CompleteAnime {
  final String title;
  final String slug;
  final String poster;
  final String episodeCount;
  final String rating;
  final String lastReleaseDate;
  final String otakudesuUrl;

  CompleteAnime({
    required this.title,
    required this.slug,
    required this.poster,
    required this.episodeCount,
    required this.rating,
    required this.lastReleaseDate,
    required this.otakudesuUrl,
  });

  factory CompleteAnime.fromJson(Map<String, dynamic> json) {
    return CompleteAnime(
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      poster: json['poster'] ?? '',
      episodeCount: json['episode_count'] ?? '',
      rating: json['rating'] ?? '',
      lastReleaseDate: json['last_release_date'] ?? '',
      otakudesuUrl: json['otakudesu_url'] ?? '',
    );
  }
}
