// lib/model/search_anime_model.dart

class UnlimitedAnime {
  final String title;
  final String animeId;
  final String href;
  final String otakudesuUrl;

  UnlimitedAnime({
    required this.title,
    required this.animeId,
    required this.href,
    required this.otakudesuUrl,
  });

  factory UnlimitedAnime.fromJson(Map<String, dynamic> json) {
    return UnlimitedAnime(
      title: json['title'] ?? '',
      animeId: json['animeId'] ?? '',
      href: json['href'] ?? '',
      otakudesuUrl: json['otakudesuUrl'] ?? '',
    );
  }
}

class UnlimitedAnimeGroup {
  final String startWith;
  final List<UnlimitedAnime> animeList;

  UnlimitedAnimeGroup({
    required this.startWith,
    required this.animeList,
  });

  factory UnlimitedAnimeGroup.fromJson(Map<String, dynamic> json) {
    return UnlimitedAnimeGroup(
      startWith: json['startWith'] ?? '',
      animeList: (json['animeList'] as List)
          .map((item) => UnlimitedAnime.fromJson(item))
          .toList(),
    );
  }
}

class UnlimitedAnimeResponse {
  final List<UnlimitedAnimeGroup> list;

  UnlimitedAnimeResponse({
    required this.list,
  });

  factory UnlimitedAnimeResponse.fromJson(Map<String, dynamic> json) {
    return UnlimitedAnimeResponse(
      list: (json['list'] as List)
          .map((item) => UnlimitedAnimeGroup.fromJson(item))
          .toList(),
    );
  }
}

class SearchAnimeGenre {
  final String name;
  final String slug;
  final String otakudesuUrl;

  SearchAnimeGenre({
    required this.name,
    required this.slug,
    required this.otakudesuUrl,
  });

  factory SearchAnimeGenre.fromJson(Map<String, dynamic> json) {
    return SearchAnimeGenre(
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      otakudesuUrl: json['otakudesu_url'] ?? '',
    );
  }
}

class SearchAnimeResult {
  final String title;
  final String slug;
  final String poster;
  final List<SearchAnimeGenre> genres;
  final String status;
  final String rating;
  final String url;

  SearchAnimeResult({
    required this.title,
    required this.slug,
    required this.poster,
    required this.genres,
    required this.status,
    required this.rating,
    required this.url,
  });

  factory SearchAnimeResult.fromJson(Map<String, dynamic> json) {
    return SearchAnimeResult(
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      poster: json['poster'] ?? '',
      genres: (json['genres'] as List)
          .map((item) => SearchAnimeGenre.fromJson(item))
          .toList(),
      status: json['status'] ?? '',
      rating: json['rating'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

class SearchAnimeResponse {
  final List<SearchAnimeResult> data;

  SearchAnimeResponse({
    required this.data,
  });

  factory SearchAnimeResponse.fromJson(List<dynamic> json) {
    return SearchAnimeResponse(
      data: json.map((item) => SearchAnimeResult.fromJson(item)).toList(),
    );
  }
}