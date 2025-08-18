import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/services/modals/song.dart';
import 'package:musify/services/providers/song_selection_provider.dart';
import 'package:musify/utils/colors.dart';
import 'package:musify/utils/spacers.dart';
import 'package:musify/utils/text.dart';
import 'package:musify/widgets/buttons/play_button.dart';

class SongSelectionBar extends StatelessWidget {
  const SongSelectionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        bool isSongSelectionOn = ref.watch(turnOnOffSongSelectionProvider);
        final songSelectionNotifier = ref.watch(
          turnOnOffSongSelectionProvider.notifier,
        );
        final selectedSong = ref.watch(songSelectionProvider);
        final selectedSongNotifier = ref.watch(songSelectionProvider.notifier);
        return isSongSelectionOn
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  border: Border(
                    top: BorderSide(color: AppColors.surfaceMuted, width: 0.7),
                  ),
                ),
                child: Row(
                  children: [
                    whiteTextMedium(
                      'Selected songs (${selectedSong.songsOrder.length})',
                    ),
                    const Spacer(),
                    PlayButton(
                      songs: List.generate(
                        selectedSong.songsOrder.length,
                        (index) => selectedSong
                            .selectedSongs[selectedSong.songsOrder[index]],
                      ).whereType<Song>().toList(),
                      callback: () {
                        songSelectionNotifier.stop();
                        selectedSongNotifier.clear();
                      },
                    ),
                    w10,
                    IconButton(
                      onPressed: () {
                        songSelectionNotifier.stop();
                        selectedSongNotifier.clear();
                      },
                      icon: Icon(Icons.cancel, color: AppColors.surfaceWhite),
                    ),
                  ],
                ),
              )
            : Container();
      },
    );
  }
}
