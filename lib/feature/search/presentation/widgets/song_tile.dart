import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/utils/app_navigator.dart';
import 'package:musify/feature/song/data/models/new_song.dart';
import 'package:musify/functions/play_song.dart';
import 'package:musify/feature/song/screens/song_details_screen.dart';
import 'package:musify/core/services/providers/audio_player_provider.dart';
import 'package:musify/feature/song/providers/song_selection_provider.dart';
import 'package:musify/core/utils/colors.dart';
import 'package:musify/core/utils/duration_label.dart';
import 'package:musify/core/utils/images.dart';

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

    return Material(
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
                if (!isSameSong) {
                  playSong(song: song, audioProvider: audioProvider);
                }
              },
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        minTileHeight: 46,
        horizontalTitleGap: 8,
        leading: GestureDetector(
          onTap: () => AppNavigator.push(SongDetailsScreen(song: song)),
          child: CachedNetworkImage(
            imageUrl: song.media.coverImage,
            placeholder: (context, url) => CircleAvatar(
              radius: 23,
              backgroundImage: AssetImage(AppImages.coverImage),
            ),
            errorWidget: (context, url, error) => CircleAvatar(
              radius: 23,
              backgroundImage: AssetImage(AppImages.coverImage),
            ),
            imageBuilder: (context, imageProvider) =>
                CircleAvatar(radius: 23, backgroundImage: imageProvider),
          ),
        ),
        title: Text(song.title),
        subtitle: Text(song.getArtists()),
        trailing: isSongSelectionOn
            ? Icon(
                isSongSelected ? Icons.check : null,
                color: AppColors.onSuccess,
              )
            : Text(durationLabel(song.media.duration)),
      ),
    );
  }
}
