import 'package:animeku_v2/page/video_page/controller/video_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPage extends GetView<VideoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.episodeDetail?.episode ?? 'Loading...',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.fullscreen, color: Colors.white),
              onPressed: () {
                SystemChrome.setEnabledSystemUIMode(
                  SystemUiMode.immersiveSticky,
                );
                _showSnackbar('Fullscreen mode activated');
              },
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return _buildLoadingWidget();
        }

        final episode = controller.episodeDetail;
        if (episode == null) {
          return _buildErrorWidget();
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              // Video Player Section
              _buildVideoPlayer(episode),

              // Content Section
              _buildContentSection(episode),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF1A1A1A),
            const Color(0xFF0F0F0F),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Loading episode...',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF1A1A1A),
            const Color(0xFF0F0F0F),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                Icons.error_outline,
                size: 40,
                color: Colors.red[300],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Episode not found',
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please try again or go back',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer(episode) {
    return Container(
      height: 220,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..loadRequest(Uri.parse(episode.streamUrl)),
            ),
            // Gradient overlay for better aesthetics
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection(episode) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Episode Navigation
            _buildEpisodeNavigation(episode),

            const SizedBox(height: 24),

            // Episode Info
            _buildEpisodeInfo(episode),

            const SizedBox(height: 24),

            // Download Section
            _buildDownloadSection(episode),
          ],
        ),
      ),
    );
  }

  Widget _buildEpisodeNavigation(episode) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: episode.hasPreviousEpisode
                    ? LinearGradient(
                        colors: [Colors.grey[700]!, Colors.grey[800]!],
                      )
                    : null,
                color: episode.hasPreviousEpisode ? null : Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton.icon(
                onPressed: episode.hasPreviousEpisode
                    ? controller.goToPreviousEpisode
                    : null,
                icon: const Icon(Icons.skip_previous, size: 20),
                label: const Text(
                  'Previous',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: episode.hasNextEpisode
                    ? const LinearGradient(
                        colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                      )
                    : null,
                color: episode.hasNextEpisode ? null : Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton.icon(
                onPressed:
                    episode.hasNextEpisode ? controller.goToNextEpisode : null,
                icon: const Icon(Icons.skip_next, size: 20),
                label: const Text(
                  'Next',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEpisodeInfo(episode) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Now Playing',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  episode.episode ?? 'Episode',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'HD',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadSection(episode) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Theme(
        data: ThemeData.dark().copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          title: const Text(
            'Download Options',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.download_rounded,
              color: Colors.blue,
              size: 22,
            ),
          ),
          iconColor: Colors.white,
          collapsedIconColor: Colors.grey[400],
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  if (episode.downloadUrls.mp4.isNotEmpty) ...[
                    _buildFormatHeader('MP4 Format', Icons.video_file),
                    ...episode.downloadUrls.mp4
                        .map((quality) => _buildQualitySection(quality, 'MP4')),
                  ],
                  if (episode.downloadUrls.mkv.isNotEmpty) ...[
                    _buildFormatHeader('MKV Format', Icons.video_library),
                    ...episode.downloadUrls.mkv
                        .map((quality) => _buildQualitySection(quality, 'MKV')),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormatHeader(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 20),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQualitySection(quality, format) {
    return Theme(
      data: ThemeData.dark().copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        title: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  format,
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                quality.resolution,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        iconColor: Colors.white,
        collapsedIconColor: Colors.grey[400],
        children: quality.urls.map<Widget>((url) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF0F0F0F),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.white.withOpacity(0.05),
                width: 1,
              ),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _getProviderColor(url.provider).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getProviderIcon(url.provider),
                  color: _getProviderColor(url.provider),
                  size: 18,
                ),
              ),
              title: Text(
                url.provider,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              trailing: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.launch,
                  color: Colors.blue,
                  size: 16,
                ),
              ),
              onTap: () => _launchUrl(url.url, url.provider),
            ),
          );
        }).toList(),
      ),
    );
  }

  IconData _getProviderIcon(String provider) {
    switch (provider.toLowerCase()) {
      case 'mega':
        return Icons.cloud_download_rounded;
      case 'gofile':
        return Icons.folder_rounded;
      case 'odfiles':
        return Icons.insert_drive_file_rounded;
      case 'mediafire':
        return Icons.storage_rounded;
      case 'zippyshare':
        return Icons.archive_rounded;
      default:
        return Icons.download_rounded;
    }
  }

  Color _getProviderColor(String provider) {
    switch (provider.toLowerCase()) {
      case 'mega':
        return Colors.red;
      case 'gofile':
        return Colors.green;
      case 'odfiles':
        return Colors.orange;
      case 'mediafire':
        return Colors.blue;
      case 'zippyshare':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  void _launchUrl(String url, String provider) {
    _showSnackbar('Opening $provider download link...');
    // Implement URL launcher
  }

  void _showSnackbar(String message) {
    Get.snackbar(
      '',
      message,
      backgroundColor: const Color(0xFF2A2A2A),
      colorText: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      animationDuration: const Duration(milliseconds: 300),
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(
        Icons.info_outline,
        color: Colors.blue[300],
      ),
      shouldIconPulse: false,
    );
  }
}
