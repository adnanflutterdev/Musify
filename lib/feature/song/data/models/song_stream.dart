import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class SongStream {
  final double bufferedPosition;
  final double currentPosition;
  final MediaItem? mediaItem;
  final PlaybackState playbackState;
  final bool shuffleStream;
  final LoopMode loopStream;

  const SongStream(
    this.bufferedPosition,
    this.currentPosition,
    this.mediaItem,
    this.playbackState,
    this.shuffleStream,
    this.loopStream,
  );
}
