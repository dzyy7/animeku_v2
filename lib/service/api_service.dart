import 'dart:convert';
import 'package:animeku_v2/model/anime_detail_model.dart';
import 'package:animeku_v2/model/episode_detail_model.dart';
import 'package:animeku_v2/page/anime_page/data/home_data.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:http/http.dart' as http;


class ApiService extends GetxService {
  static const String baseUrl = 'https://www.sankavollerei.com/anime';

  Future<HomeData> getHomeData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/home'));
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
      final response = await http.get(Uri.parse('$baseUrl/anime/$slug'));
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
      final response = await http.get(Uri.parse('$baseUrl/episode/$slug'));
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
}
