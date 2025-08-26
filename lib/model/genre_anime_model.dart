import 'package:animeku_v2/model/anime_detail_model.dart';
import 'package:animeku_v2/model/completed_anime_model.dart';

class GenreItem {
  final String name;
  final String slug;
  final String otakudesuUrl;

  GenreItem({
    required this.name,
    required this.slug,
    required this.otakudesuUrl,
  });

  factory GenreItem.fromJson(Map<String, dynamic> json) {
    return GenreItem(
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      otakudesuUrl: json['otakudesu_url'] ?? '',
    );
  }
}

class GenreAnime {
  final String title;
  final String slug;
  final String poster;
  final String rating;
  final String? episodeCount;
  final String season;
  final String studio;
  final List<Genre> genres;
  final String synopsis;
  final String otakudesuUrl;

  GenreAnime({
    required this.title,
    required this.slug,
    required this.poster,
    required this.rating,
    this.episodeCount,
    required this.season,
    required this.studio,
    required this.genres,
    required this.synopsis,
    required this.otakudesuUrl,
  });

  factory GenreAnime.fromJson(Map<String, dynamic> json) {
    return GenreAnime(
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      poster: json['poster'] ?? '',
      rating: json['rating'] ?? '',
      episodeCount: json['episode_count']?.toString(),
      season: json['season'] ?? '',
      studio: json['studio'] ?? '',
      genres:
          (json['genres'] as List).map((item) => Genre.fromJson(item)).toList(),
      synopsis: json['synopsis'] ?? '',
      otakudesuUrl: json['otakudesu_url'] ?? '',
    );
  }
}

// Fixed PaginationData class to match the API response
class PaginationData {
  final int currentPage;
  final int lastVisiblePage;
  final bool hasNextPage;
  final int? nextPage;
  final bool hasPreviousPage;
  final int? previousPage;

  PaginationData({
    required this.currentPage,
    required this.lastVisiblePage,
    required this.hasNextPage,
    this.nextPage,
    required this.hasPreviousPage,
    this.previousPage,
  });

  factory PaginationData.fromJson(Map<String, dynamic> json) {
    return PaginationData(
      currentPage: json['current_page'] ?? 1,
      lastVisiblePage: json['last_visible_page'] ?? 1,
      hasNextPage: json['has_next_page'] ?? false,
      nextPage: json['next_page'],
      hasPreviousPage: json['has_previous_page'] ?? false,
      previousPage: json['previous_page'],
    );
  }
}

class GenreAnimeResponse {
  final PaginationData paginationData;
  final List<GenreAnime> anime;

  GenreAnimeResponse({
    required this.paginationData,
    required this.anime,
  });

  // Fixed to match the actual API response structure
  factory GenreAnimeResponse.fromJson(Map<String, dynamic> json) {
    return GenreAnimeResponse(
      paginationData: PaginationData.fromJson(json['pagination'] ??
          {}), // Changed from 'paginationData' to 'pagination'
      anime: (json['anime'] as List? ?? [])
          .map((item) => GenreAnime.fromJson(item))
          .toList(),
    );
  }
}

class GenreListResponse {
  final List<GenreItem> genres;

  GenreListResponse({
    required this.genres,
  });

  factory GenreListResponse.fromJson(List<dynamic> json) {
    return GenreListResponse(
      genres: json.map((item) => GenreItem.fromJson(item)).toList(),
    );
  }
}
