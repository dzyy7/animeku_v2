import 'package:animeku_v2/model/episode_detail_model.dart';
import 'package:animeku_v2/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  final _isLoading = false.obs;
  final _episodeDetail = Rxn<EpisodeDetailData>();
  final _currentStreamUrl = ''.obs;
  final _selectedQuality = ''.obs;
  final _selectedServer = ''.obs;
  final _isLoadingStream = false.obs;

  bool get isLoading => _isLoading.value;
  EpisodeDetailData? get episodeDetail => _episodeDetail.value;
  String get currentStreamUrl => _currentStreamUrl.value;
  String get selectedQuality => _selectedQuality.value;
  String get selectedServer => _selectedServer.value;
  bool get isLoadingStream => _isLoadingStream.value;

  @override
  void onInit() {
    super.onInit();
    final slug = Get.parameters['slug'];
    if (slug != null) {
      loadEpisodeDetail(slug);
    }
  }

  Future<void> loadEpisodeDetail(String slug) async {
    try {
      _isLoading.value = true;
      final data = await _apiService.getEpisodeDetail(slug);
      _episodeDetail.value = data;
      
      // Auto-select first available server
      await _selectDefaultServer();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> _selectDefaultServer() async {
    final episode = _episodeDetail.value;
    if (episode != null && episode.streamServers.qualities.isNotEmpty) {
      final firstQuality = episode.streamServers.qualities.first;
      if (firstQuality.serverList.isNotEmpty) {
        final firstServer = firstQuality.serverList.first;
        await selectServer(firstQuality.title, firstServer);
      }
    }
  }

  Future<void> selectServer(String quality, ServerInfo server) async {
    try {
      _isLoadingStream.value = true;
      _selectedQuality.value = quality;
      _selectedServer.value = server.title;
      
      // Get server URL from href (remove the leading '/')
      final serverId = server.href.replaceFirst('/anime/server/', '');
      final serverResponse = await _apiService.getServerStream(serverId);
      
      _currentStreamUrl.value = serverResponse.url;
      
      Get.snackbar(
        'Server Changed', 
        'Now playing: $quality - ${server.title}',
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Server Error', 
        'Failed to load ${server.title}. Please try another server.',
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      _isLoadingStream.value = false;
    }
  }

  void goToNextEpisode() {
    if (episodeDetail?.hasNextEpisode == true && 
        episodeDetail?.nextEpisode != null) {
      Get.offNamed('/video', 
          parameters: {'slug': episodeDetail!.nextEpisode!.slug});
    }
  }

  void goToPreviousEpisode() {
    if (episodeDetail?.hasPreviousEpisode == true && 
        episodeDetail?.previousEpisode != null) {
      Get.offNamed('/video', 
          parameters: {'slug': episodeDetail!.previousEpisode!.slug});
    }
  }

  List<QualityOption> getAvailableQualities() {
    return episodeDetail?.streamServers.qualities ?? [];
  }

  void showServerSelection() {
    final qualities = getAvailableQualities();
    if (qualities.isEmpty) return;

    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Select Quality & Server',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: qualities.length,
                itemBuilder: (context, qualityIndex) {
                  final quality = qualities[qualityIndex];
                  return ExpansionTile(
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.grey[400],
                    title: Text(
                      quality.title,
                      style: TextStyle(
                        color: selectedQuality == quality.title 
                            ? const Color(0xFF4A90E2) 
                            : Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: quality.serverList.map((server) {
                      final isSelected = selectedQuality == quality.title && 
                                        selectedServer == server.title;
                      return ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isSelected
                                  ? [const Color(0xFF4A90E2), const Color(0xFF357ABD)]
                                  : [Colors.grey[700]!, Colors.grey[800]!],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getServerIcon(server.title),
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          server.title,
                          style: TextStyle(
                            color: isSelected ? const Color(0xFF4A90E2) : Colors.white,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check, color: Color(0xFF4A90E2))
                            : null,
                        onTap: () async {
                          Get.back();
                          await selectServer(quality.title, server);
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      isDismissible: true,
      enableDrag: true,
    );
  }

  IconData _getServerIcon(String serverTitle) {
    switch (serverTitle.toLowerCase()) {
      case 'vidhide':
        return Icons.visibility;
      case 'pdrain':
        return Icons.cloud_download;
      case 'odstream':
        return Icons.play_circle;
      case 'mega':
        return Icons.storage;
      case 'ondesu3':
      case 'ondesuhd':
        return Icons.hd;
      default:
        return Icons.play_arrow;
    }
  }
}