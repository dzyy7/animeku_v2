import 'package:animeku_v2/page/video_page/controller/video_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayerView extends GetView<VideoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Obx(() => Text(
          controller.episodeDetail?.episode ?? 'Loading...',
          style: const TextStyle(fontSize: 16),
        )),
        actions: [
          IconButton(
            icon: const Icon(Icons.fullscreen),
            onPressed: () {
              // Toggle fullscreen
              SystemChrome.setEnabledSystemUIMode(
                SystemUiMode.immersiveSticky,
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final episode = controller.episodeDetail;
        if (episode == null) {
          return const Center(child: Text('Episode not found'));
        }

        return Column(
          children: [
            // Video Player
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                child: WebViewWidget(
                  controller: WebViewController()
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..loadRequest(Uri.parse(episode.streamUrl)),
                ),
              ),
            ),
            
            // Controls
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Episode Navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: episode.hasPreviousEpisode 
                              ? controller.goToPreviousEpisode 
                              : null,
                          icon: const Icon(Icons.skip_previous),
                          label: const Text('Previous'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: episode.hasNextEpisode 
                              ? controller.goToNextEpisode 
                              : null,
                          icon: const Icon(Icons.skip_next),
                          label: const Text('Next'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Download Options
                  _buildDownloadSection(episode),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildDownloadSection(episode) {
    return Card(
      child: ExpansionTile(
        title: const Text('Download Options'),
        leading: const Icon(Icons.download),
        children: [
          if (episode.downloadUrls.mp4.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'MP4 Format',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            ...episode.downloadUrls.mp4.map((quality) => 
                _buildQualitySection(quality, 'MP4')),
          ],
          
          if (episode.downloadUrls.mkv.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'MKV Format',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            ...episode.downloadUrls.mkv.map((quality) => 
                _buildQualitySection(quality, 'MKV')),
          ],
        ],
      ),
    );
  }

  Widget _buildQualitySection(quality, format) {
    return ExpansionTile(
      title: Text('$format ${quality.resolution}'),
      children: quality.urls.map<Widget>((url) {
        return ListTile(
          leading: Icon(
            _getProviderIcon(url.provider),
            color: Colors.blue,
          ),
          title: Text(url.provider),
          trailing: const Icon(Icons.launch),
          onTap: () => _launchUrl(url.url),
        );
      }).toList(),
    );
  }

  IconData _getProviderIcon(String provider) {
    switch (provider.toLowerCase()) {
      case 'mega':
        return Icons.cloud_download;
      case 'gofile':
        return Icons.folder;
      case 'odfiles':
        return Icons.insert_drive_file;
      default:
        return Icons.download;
    }
  }

  void _launchUrl(String url) {
    // Implement URL launcher
    Get.snackbar('Download', 'Opening download link...');
  }
}
