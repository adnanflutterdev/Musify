import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/functions/play_song.dart';
import 'package:musify/screens/song_details_screen.dart';
import 'package:musify/core/services/modals/song.dart';
import 'package:musify/core/services/providers/audio_player_provider.dart';
import 'package:musify/core/services/providers/song_selection_provider.dart';
import 'package:musify/core/utils/colors.dart';
import 'package:musify/core/utils/duration_label.dart';
import 'package:musify/core/utils/images.dart';
import 'package:musify/core/utils/text.dart';

class SongTile extends ConsumerWidget {
  const SongTile({super.key, required this.song, required this.isSameSong});
  final Song song;
  final bool isSameSong;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioProvider = ref.watch(audioPlayerProvider);
    bool isSongSelectionOn = ref.watch(turnOnOffSongSelectionProvider);
    final songSelectionNotifier = ref.watch(
      turnOnOffSongSelectionProvider.notifier,
    );
    final selectedSongNotifier = ref.watch(songSelectionProvider.notifier);

    bool isSongSelected = ref.watch(isSongSelectedProvider(song.id));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        color: isSameSong ? AppColors.primary : Colors.transparent,
        child: ListTile(
          onLongPress: isSongSelectionOn
              ? () {
                  selectedSongNotifier.toggleSongSelection(song);
                }
              : () {
                  songSelectionNotifier.start();
                  selectedSongNotifier.toggleSongSelection(song);
                },
          onTap: isSongSelectionOn
              ? () {
                  selectedSongNotifier.toggleSongSelection(song);
                }
              : () {
                  isSameSong
                      ? null
                      : playSong(song: song, audioProvider: audioProvider);
                },
          contentPadding: EdgeInsets.symmetric(horizontal: 5),
          minTileHeight: 46,
          horizontalTitleGap: 8,
          leading: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SongDetailsScreen(song: song),
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: song.coverImage,
              placeholder: (context, url) => CircleAvatar(
                radius: 23,
                backgroundImage: AssetImage(coverImage),
              ),
              errorWidget: (context, url, error) => CircleAvatar(
                radius: 23,
                backgroundImage: AssetImage(coverImage),
              ),
              imageBuilder: (context, imageProvider) =>
                  CircleAvatar(radius: 23, backgroundImage: imageProvider),
            ),
          ),
          title: tileTitle(song.songName),
          subtitle: tileSubTitle(song.artistName),
          trailing: isSongSelectionOn
              ? Icon(
                  isSongSelected ? Icons.check : null,
                  color: AppColors.onSuccess,
                )
              : tileTrailing(durationLabel(song.duration)),
        ),
      ),
    );
  }
}
