import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/services/modals/song.dart';
import 'package:musify/services/providers/audio_player_provider.dart';
import 'package:musify/services/providers/song_stream_provider.dart';
import 'package:musify/utils/colors.dart';

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
      error: (error, stackTrace) => Text('Error'),
      loading: () => CircularProgressIndicator(color: AppColors.surfaceWhite),
      data: (data) {
        final mediaItem = data.mediaItem;
        final isPlaying = data.playbackState.playing;

        return GestureDetector(
          onTap: () {
            if (callback != null) {
              callback?.call();
            }
            if (song != null) {
              bool isDiffSong = mediaItem == null || mediaItem.id != song!.url;
              if (isDiffSong) {
                Song s = song!;
                audioProvider.playSong(
                  MediaItem(
                    id: s.url,
                    title: s.songName,
                    artUri: Uri.parse(s.coverImage),
                    artist: s.artistName,
                    duration: Duration(seconds: s.duration),
                    extras: {'songId': s.id, 'listen': s.listen},
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
                      id: song.url,
                      title: song.songName,
                      artUri: Uri.parse(song.coverImage),
                      artist: song.artistName,
                      duration: Duration(seconds: song.duration),
                      extras: {'songId': song.id, 'listen': song.listen},
                    ),
                  )
                  .toList();
              audioProvider.playPlaylist(mediaItems, 0);
            }
          },
          child:
              song != null &&
                      (mediaItem == null || mediaItem.id != song!.url) ||
                  songs != null && songs!.length > 2
              ? Container(
                  width: size ?? 30,
                  height: size ?? 30,
                  decoration: BoxDecoration(
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
