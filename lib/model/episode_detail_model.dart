class ServerInfo {
  final String title;
  final String serverId;
  final String href;

  ServerInfo({
    required this.title,
    required this.serverId,
    required this.href,
  });

  factory ServerInfo.fromJson(Map<String, dynamic> json) {
    return ServerInfo(
      title: json['title'] ?? '',
      serverId: json['serverId'] ?? '',
      href: json['href'] ?? '',
    );
  }
}

class QualityOption {
  final String title;
  final List<ServerInfo> serverList;

  QualityOption({
    required this.title,
    required this.serverList,
  });

  factory QualityOption.fromJson(Map<String, dynamic> json) {
    return QualityOption(
      title: json['title'] ?? '',
      serverList: (json['serverList'] as List)
          .map((item) => ServerInfo.fromJson(item))
          .toList(),
    );
  }
}

class StreamServers {
  final List<QualityOption> qualities;

  StreamServers({
    required this.qualities,
  });

  factory StreamServers.fromJson(Map<String, dynamic> json) {
    return StreamServers(
      qualities: (json['qualities'] as List)
          .map((item) => QualityOption.fromJson(item))
          .toList(),
    );
  }
}

class DownloadUrl {
  final String provider;
  final String url;

  DownloadUrl({
    required this.provider,
    required this.url,
  });

  factory DownloadUrl.fromJson(Map<String, dynamic> json) {
    return DownloadUrl(
      provider: json['provider'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

class VideoQuality {
  final String resolution;
  final List<DownloadUrl> urls;

  VideoQuality({
    required this.resolution,
    required this.urls,
  });

  factory VideoQuality.fromJson(Map<String, dynamic> json) {
    return VideoQuality(
      resolution: json['resolution'] ?? '',
      urls: (json['urls'] as List)
          .map((item) => DownloadUrl.fromJson(item))
          .toList(),
    );
  }
}

class DownloadUrls {
  final List<VideoQuality> mp4;
  final List<VideoQuality> mkv;

  DownloadUrls({
    required this.mp4,
    required this.mkv,
  });

  factory DownloadUrls.fromJson(Map<String, dynamic> json) {
    return DownloadUrls(
      mp4: (json['mp4'] as List)
          .map((item) => VideoQuality.fromJson(item))
          .toList(),
      mkv: (json['mkv'] as List)
          .map((item) => VideoQuality.fromJson(item))
          .toList(),
    );
  }
}

class NextEpisode {
  final String slug;
  final String otakudesuUrl;

  NextEpisode({
    required this.slug,
    required this.otakudesuUrl,
  });

  factory NextEpisode.fromJson(Map<String, dynamic> json) {
    return NextEpisode(
      slug: json['slug'] ?? '',
      otakudesuUrl: json['otakudesu_url'] ?? '',
    );
  }
}

class PreviousEpisode {
  final String slug;
  final String otakudesuUrl;

  PreviousEpisode({
    required this.slug,
    required this.otakudesuUrl,
  });

  factory PreviousEpisode.fromJson(Map<String, dynamic> json) {
    return PreviousEpisode(
      slug: json['slug'] ?? '',
      otakudesuUrl: json['otakudesu_url'] ?? '',
    );
  }
}

class EpisodeAnime {
  final String slug;
  final String otakudesuUrl;

  EpisodeAnime({
    required this.slug,
    required this.otakudesuUrl,
  });

  factory EpisodeAnime.fromJson(Map<String, dynamic> json) {
    return EpisodeAnime(
      slug: json['slug'] ?? '',
      otakudesuUrl: json['otakudesu_url'] ?? '',
    );
  }
}

class EpisodeDetailData {
  final String episode;
  final EpisodeAnime anime;
  final bool hasNextEpisode;
  final NextEpisode? nextEpisode;
  final bool hasPreviousEpisode;
  final PreviousEpisode? previousEpisode;
  final String streamUrl; // Keep for backward compatibility
  final DownloadUrls downloadUrls;
  final StreamServers streamServers; // New field

  EpisodeDetailData({
    required this.episode,
    required this.anime,
    required this.hasNextEpisode,
    this.nextEpisode,
    required this.hasPreviousEpisode,
    this.previousEpisode,
    required this.streamUrl,
    required this.downloadUrls,
    required this.streamServers,
  });

  factory EpisodeDetailData.fromJson(Map<String, dynamic> json) {
    return EpisodeDetailData(
      episode: json['episode'] ?? '',
      anime: EpisodeAnime.fromJson(json['anime']),
      hasNextEpisode: json['has_next_episode'] ?? false,
      nextEpisode: json['next_episode'] != null 
          ? NextEpisode.fromJson(json['next_episode']) 
          : null,
      hasPreviousEpisode: json['has_previous_episode'] ?? false,
      previousEpisode: json['previous_episode'] != null 
          ? PreviousEpisode.fromJson(json['previous_episode']) 
          : null,
      streamUrl: json['stream_url'] ?? '',
      downloadUrls: DownloadUrls.fromJson(json['download_urls']),
      streamServers: StreamServers.fromJson(json['stream_servers']),
    );
  }
}