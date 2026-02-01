import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/services/modals/song.dart';
import 'package:musify/core/services/providers/song_selection_provider.dart';
import 'package:musify/core/utils/colors.dart';
import 'package:musify/core/utils/text.dart';
import 'package:musify/widgets/buttons/custom_button.dart';
import 'package:musify/widgets/buttons/play_button.dart';

class SongSelectionBar extends StatelessWidget {
  const SongSelectionBar({super.key, this.forPlaylist = false});
  final bool forPlaylist;

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
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  border: Border(
                    top: BorderSide(color: AppColors.surfaceMuted, width: 0.7),
                  ),
                ),
                child: Row(
                  children: [
                    primaryTextMedium(
                      'Selected songs (${selectedSong.songsOrder.length})',
                    ),
                    if (!forPlaylist)
                      TextButton(
                        onPressed: () {
                          songSelectionNotifier.stop();
                          selectedSongNotifier.clear();
                        },
                        child: whiteTextSmall('Cancel'),
                      ),
                    const Spacer(),
                    if (!forPlaylist)
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
                    if (forPlaylist)
                      CustomTextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        title: 'Add',
                      ),
                  ],
                ),
              )
            : Container();
      },
    );
  }
}
