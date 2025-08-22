import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/screens/create_playlist_screen.dart';
import 'package:musify/services/providers/playlist_provider.dart';
import 'package:musify/utils/colors.dart';
import 'package:musify/utils/text.dart';
import 'package:musify/widgets/custom_app_bar.dart';
import 'package:musify/widgets/home_tab_widgets/song_list.dart';

class PlaylistTab extends ConsumerWidget {
  const PlaylistTab({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void push() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreatePlaylistScreen()),
      );
    }

    final playlists = ref.watch(playlistProvider);

    return Column(
      children: [
        CustomAppBar(
          title: appBarText('My Playlists'),
          hasLeading: false,
          trailing: IconButton(
            onPressed: push,
            icon: Icon(Icons.add_sharp, color: AppColors.surfaceWhite),
          ),
        ),
        if (playlists.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return SongList(
                  title: playlist['title'],
                  songs: playlist['songs'],
                  editable: true,
                  canEditSongsList: true,
                );
              },
            ),
          ),
        if (playlists.isEmpty)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                whiteTextSmall('No playlists'),
                TextButton(
                  onPressed: push,
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.surfaceVariant,
                  ),
                  child: whiteTextSmall('Create playlist'),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
