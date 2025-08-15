import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/services/modals/song.dart';
import 'package:musify/services/providers/audio_player.dart';
import 'package:musify/services/providers/song_stream.dart';
import 'package:musify/utils/colors.dart';

class PlayButton extends ConsumerWidget {
  const PlayButton({super.key, required this.songs, this.size});
  final double? size;
  final List<Song> songs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songStream = ref.watch(songStreamProvider);
    final audioProvider = ref.watch(audioPlayerProvider);
    return songStream.when(
      error: (error, stackTrace) => Text('Error'),
      loading: () => CircularProgressIndicator(color: AppColors.white),
      data: (data) {
        final mediaItem = data.mediaItem;
        final isPlaying = data.playbackState.playing;

        bool isDiffSong = mediaItem == null || mediaItem.id != songs[0].url;

        return GestureDetector(
          onTap: () {
            if (songs.length == 1) {
              if (isDiffSong) {
                Song song = songs[0];
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
              } else {
                if (isPlaying) {
                  audioProvider.pause();
                } else {
                  audioProvider.play();
                }
              }
            } else {
              List<MediaItem> mediaItems = songs
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
          child: isDiffSong || songs.length > 2
              ? Container(
                  width: size ?? 30,
                  height: size ?? 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.buttonPink,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: AppColors.white,
                    size: size == null ? 23 : (size! - 7),
                  ),
                )
              : Container(),
        );
      },
    );
  }
}
