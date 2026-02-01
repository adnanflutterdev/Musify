import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/services/providers/songs_provider.dart';
import 'package:musify/widgets/home_tab_widgets/song_list.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final top20SongsList = ref.watch(top20Songs);
              return top20SongsList.when(
                error: (error, stackTrace) => Container(),
                loading: () => Container(),
                data: (data) => SongList(title: 'Top 20 Songs', songs: data),
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              return SongList(
                title: 'Recently Played',
                songs: ref.watch(recentlyPlayedSongsProvider),
                canEditSongsList: true,
                editable: true,
                // isFavouriteVisible: true,
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              return SongList(
                title: 'Favourite Songs',
                songs: ref.watch(favouriteSongsProvider),
                canEditSongsList: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
