import 'package:musify/core/utils/model_helper.dart';

class AppLimits {
  final int freeDownloads;
  final int maxPlaylistSongs;
  final int maxPlaylists;
  final int maxQueueSize;

  const AppLimits({
    required this.freeDownloads,
    required this.maxPlaylistSongs,
    required this.maxPlaylists,
    required this.maxQueueSize,
  });

  factory AppLimits.fromJson(Map<String, dynamic> json) {
    return AppLimits(
      freeDownloads: parseInt(json['freeDownloads']),
      maxPlaylistSongs: parseInt(json['maxPlaylistSongs']),
      maxPlaylists: parseInt(json['maxPlaylists']),
      maxQueueSize: parseInt(json['maxQueueSize']),
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'freeDownloads': freeDownloads,
      'maxPlaylistSongs': maxPlaylistSongs,
      'maxPlaylists': maxPlaylists,
      'maxQueueSize': maxQueueSize,
    };
  }
}