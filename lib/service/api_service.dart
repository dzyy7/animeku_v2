import 'dart:convert';
import 'package:animeku_v2/model/anime_detail_model.dart';
import 'package:animeku_v2/model/completed_anime_model.dart';
import 'package:animeku_v2/model/episode_detail_model.dart';
import 'package:animeku_v2/model/genre_anime_model.dart';
import 'package:animeku_v2/model/search_page_model.dart';

import 'package:animeku_v2/page/anime_page/data/home_data.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:http/http.dart' as http;

import '../model/schedule_anime_model.dart';

class ServerStreamResponse {
  final String creator;
  final String url;

  ServerStreamResponse({
    required this.creator,
    required this.url,
  });

  factory ServerStreamResponse.fromJson(Map<String, dynamic> json) {
    return ServerStreamResponse(
      creator: json['creator'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

class ApiService extends GetxService {
  static const String baseUrl = 'https://www.sankavollerei.com';

  Future<HomeData> getHomeData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/anime/home'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return HomeData.fromJson(data['data']);
      } else {
        throw Exception('Failed to load home data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<AnimeDetail> getAnimeDetail(String slug) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/anime/anime/$slug'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AnimeDetail.fromJson(data['data']);
      } else {
        throw Exception('Failed to load anime detail');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<EpisodeDetailData> getEpisodeDetail(String slug) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/anime/episode/$slug'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return EpisodeDetailData.fromJson(data['data']);
      } else {
        throw Exception('Failed to load episode detail');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // New method to get server stream URL
  Future<ServerStreamResponse> getServerStream(String serverId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/anime/server/$serverId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ServerStreamResponse.fromJson(data);
      } else {
        throw Exception('Failed to load server stream');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<ScheduleData> getSchedule() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/anime/schedule'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ScheduleData.fromJson(data['data']);
      } else {
        throw Exception('Failed to load schedule data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<CompleteAnimeResponse> getCompleteAnime([int page = 1]) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/anime/complete-anime/$page'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return CompleteAnimeResponse.fromJson(data['data']);
      } else {
        throw Exception('Failed to load complete anime data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<GenreListResponse> getGenreList() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/anime/genre'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return GenreListResponse.fromJson(data['data']);
      } else {
        throw Exception('Failed to load genre list');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<GenreAnimeResponse> getAnimeByGenre(String genreSlug, [int page = 1]) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/anime/genre/$genreSlug?page=$page'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return GenreAnimeResponse.fromJson(data['data']);
      } else {
        throw Exception('Failed to load anime by genre');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
  
  Future<UnlimitedAnimeResponse> getUnlimitedAnime() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/anime/unlimited'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return UnlimitedAnimeResponse.fromJson(data['data']);
      } else {
        throw Exception('Failed to load unlimited anime data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<SearchAnimeResponse> searchAnime(String keyword) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/anime/search/$keyword'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return SearchAnimeResponse.fromJson(data['data']);
      } else {
        throw Exception('Failed to search anime');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}