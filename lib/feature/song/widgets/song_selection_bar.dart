import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/utils/app_navigator.dart';
import 'package:musify/feature/song/data/models/song.dart';
import 'package:musify/feature/song/providers/song_selection_provider.dart';

import 'package:musify/core/widgets/buttons/custom_button.dart';
import 'package:musify/core/widgets/buttons/play_button.dart';

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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: context.colors.background,
                  border: Border(
                    top: BorderSide(color: context.colors.disabled, width: 0.7),
                  ),
                ),
                child: Row(
                  children: [
                    Text('Selected songs (${selectedSong.songsOrder.length})'),
                    if (!forPlaylist)
                      TextButton(
                        onPressed: () {
                          songSelectionNotifier.stop();
                          selectedSongNotifier.clear();
                        },
                        child: const Text('Cancel'),
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
                          AppNavigator.pop();
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
