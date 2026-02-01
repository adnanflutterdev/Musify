import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/services/modals/song.dart';
import 'package:musify/core/services/providers/songs_provider.dart';

class SearchNotifier extends StateNotifier<String> {
  SearchNotifier() : super('');

  void updateState(String searchedText) {
    state = searchedText;
  }

  void clearState() {
    state = '';
  }
}

final searchedTextProvider = StateNotifierProvider<SearchNotifier, String>(
  (ref) => SearchNotifier(),
);

final searchedSongProvider = Provider<List<Song>>((ref) {
  final text = ref.watch(searchedTextProvider).trim().toLowerCase();
  final allSongs = ref.watch(songsProvider).valueOrNull ?? [];

  return text.isEmpty
      ? allSongs
      : allSongs
            .map((Song song) {
              if (song.songName.toLowerCase().contains(text) ||
                  song.artistName.toLowerCase().contains(text) ||
                  song.movieName.toLowerCase().contains(text) ||
                  song.language.toLowerCase().contains(text) ||
                  song.songCategories.toLowerCase().contains(text)) {
                return song;
              } else {
                return null;
              }
            })
            .whereType<Song>()
            .toList();
});
