import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/feature/song/data/models/new_song.dart';
import 'package:musify/core/services/providers/audio_player_provider.dart';
import 'package:musify/feature/song/providers/song_stream_provider.dart';
import 'package:musify/core/utils/colors.dart';

class PlayButton extends ConsumerWidget {
  const PlayButton({super.key, this.size, this.callback, this.song, this.songs})
    : assert(
        (songs == null) != (song == null),
        'You must provide exactly one song or list of songs',
      );
  final double? size;
  final Song? song;
  final List<Song>? songs;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songStream = ref.watch(songStreamProvider);
    final audioProvider = ref.watch(audioPlayerProvider);
    return songStream.when(
      error: (error, stackTrace) => const Text('Error'),
      loading: () =>
          const CircularProgressIndicator(color: AppColors.surfaceWhite),
      data: (data) {
        final mediaItem = data.mediaItem;
        final isPlaying = data.playbackState.playing;

        return GestureDetector(
          onTap: () {
            if (callback != null) {
              callback?.call();
            }
            if (song != null) {
              bool isDiffSong = mediaItem == null || mediaItem.id != song!.media.audioUrl;
              if (isDiffSong) {
                Song s = song!;
                audioProvider.playSong(
                  MediaItem(
                    id: s.media.audioUrl,
                    title: s.title,
                    artUri: Uri.parse(s.media.coverImage),
                    artist: s.getArtists(),
                    duration: Duration(seconds: s.media.duration),
                    extras: {'songId': s.id, 'listen': s.stats.playCount},
                  ),
                );
              } else {
                if (isPlaying) {
                  audioProvider.pause();
                } else {
                  audioProvider.play();
                }
              }
            } else {
              List<MediaItem> mediaItems = songs!
                  .map(
                    (song) => MediaItem(
                      id: song.media.audioUrl,
                      title: song.title,
                      artUri: Uri.parse(song.media.coverImage),
                      artist: song.getArtists(),
                      duration: Duration(seconds: song.media.duration),
                      extras: {'songId': song.id, 'listen': song.stats.playCount},
                    ),
                  )
                  .toList();
              audioProvider.playPlaylist(mediaItems, 0);
            }
          },
          child:
              song != null &&
                      (mediaItem == null || mediaItem.id != song!.media.audioUrl) ||
                  songs != null
              ? Container(
                  width: size ?? 30,
                  height: size ?? 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryVariant,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: AppColors.surfaceWhite,
                    size: size == null ? 23 : (size! - 7),
                  ),
                )
              : Container(),
        );
      },
    );
  }
}
