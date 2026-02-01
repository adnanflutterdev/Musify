import 'package:audio_service/audio_service.dart';
import 'package:musify/core/services/audio/audio_player_handler.dart';
import 'package:musify/core/services/modals/song.dart';

void playSong({required Song song, required AudioPlayerHandler audioProvider}) {
  audioProvider.playSong(
    MediaItem(
      id: song.url,
      title: song.songName,
      artUri: Uri.parse(song.coverImage),
      artist: song.artistName,
      duration: Duration(seconds: song.duration),
      extras: {'songId': song.id, 'listen': song.listen},
    ),
  );
}
