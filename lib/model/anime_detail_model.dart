class Genre {
  final String name;
  final String slug;
  final String otakudesuUrl;

  Genre({
    required this.name,
    required this.slug,
    required this.otakudesuUrl,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      otakudesuUrl: json['otakudesu_url'] ?? '',
    );
  }
}

class Episode {
  final String episode;
  final int episodeNumber;
  final String slug;
  final String otakudesuUrl;

  Episode({
    required this.episode,
    required this.episodeNumber,
    required this.slug,
    required this.otakudesuUrl,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      episode: json['episode'] ?? '',
      episodeNumber: json['episode_number'] ?? 0,
      slug: json['slug'] ?? '',
      otakudesuUrl: json['otakudesu_url'] ?? '',
    );
  }
}

class Recommendation {
  final String title;
  final String slug;
  final String poster;
  final String otakudesuUrl;

  Recommendation({
    required this.title,
    required this.slug,
    required this.poster,
    required this.otakudesuUrl,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      poster: json['poster'] ?? '',
      otakudesuUrl: json['otakudesu_url'] ?? '',
    );
  }
}

class AnimeDetail {
  final String title;
  final String slug;
  final String japaneseTitle;
  final String poster;
  final String rating;
  final String produser;
  final String type;
  final String status;
  final String episodeCount;
  final String duration;
  final String releaseDate;
  final String studio;
  final List<Genre> genres;
  final String synopsis;
  final dynamic batch;
  final List<Episode> episodeLists;
  final List<Recommendation> recommendations;

  AnimeDetail({
    required this.title,
    required this.slug,
    required this.japaneseTitle,
    required this.poster,
    required this.rating,
    required this.produser,
    required this.type,
    required this.status,
    required this.episodeCount,
    required this.duration,
    required this.releaseDate,
    required this.studio,
    required this.genres,
    required this.synopsis,
    required this.batch,
    required this.episodeLists,
    required this.recommendations,
  });

  factory AnimeDetail.fromJson(Map<String, dynamic> json) {
    return AnimeDetail(
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      japaneseTitle: json['japanese_title'] ?? '',
      poster: json['poster'] ?? '',
      rating: json['rating'] ?? '',
      produser: json['produser'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      episodeCount: json['episode_count'] ?? '',
      duration: json['duration'] ?? '',
      releaseDate: json['release_date'] ?? '',
      studio: json['studio'] ?? '',
      genres: (json['genres'] as List)
          .map((item) => Genre.fromJson(item))
          .toList(),
      synopsis: json['synopsis'] ?? '',
      batch: json['batch'],
      episodeLists: (json['episode_lists'] as List)
          .map((item) => Episode.fromJson(item))
          .toList(),
      recommendations: (json['recommendations'] as List)
          .map((item) => Recommendation.fromJson(item))
          .toList(),
    );
  }
}