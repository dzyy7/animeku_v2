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

class CompleteAnimeData {
  final String title;
  final String slug;
  final String poster;
  final String episodeCount;
  final String rating;
  final String lastReleaseDate;
  final String otakudesuUrl;

  CompleteAnimeData({
    required this.title,
    required this.slug,
    required this.poster,
    required this.episodeCount,
    required this.rating,
    required this.lastReleaseDate,
    required this.otakudesuUrl,
  });

  factory CompleteAnimeData.fromJson(Map<String, dynamic> json) {
    return CompleteAnimeData(
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

class CompleteAnimeResponse {
  final PaginationData paginationData;
  final List<CompleteAnimeData> completeAnimeData;

  CompleteAnimeResponse({
    required this.paginationData,
    required this.completeAnimeData,
  });

  factory CompleteAnimeResponse.fromJson(Map<String, dynamic> json) {
    return CompleteAnimeResponse(
      paginationData: PaginationData.fromJson(json['paginationData']),
      completeAnimeData: (json['completeAnimeData'] as List)
          .map((item) => CompleteAnimeData.fromJson(item))
          .toList(),
    );
  }
}