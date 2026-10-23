import 'package:audio_service/audio_service.dart';
import 'package:musify/core/services/audio/audio_player_handler.dart';
import 'package:musify/feature/song/data/models/new_song.dart';

void playSong({required Song song, required AudioPlayerHandler audioProvider}) {
  audioProvider.playSong(
    MediaItem(
      id: song.media.audioUrl,
      title: song.title,
      artUri: Uri.parse(song.media.coverImage),
      artist: song.getArtists(),
      duration: Duration(seconds: song.media.duration),
      extras: {'songId': song.id, 'listen': song.stats.playCount},
    ),
  );
}
