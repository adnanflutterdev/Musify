import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/services/modals/song.dart';
import 'package:musify/services/providers/song_search_provider.dart';
import 'package:musify/services/providers/song_stream_provider.dart';
import 'package:musify/widgets/search_tab_widgets/song_tile.dart';

class SearchedSongs extends ConsumerWidget {
  const SearchedSongs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchedSongs = ref.watch(searchedSongProvider);
    final songStream = ref.watch(songStreamProvider);
    final currentSongId = songStream.asData?.value.mediaItem?.id;
    return ListView.builder(
      itemCount: searchedSongs.length,
      itemBuilder: (context, index) {
        Song song = searchedSongs[index];

        return SongTile(song: song, isSameSong: song.url == currentSongId);
      },
    );
  }
}
