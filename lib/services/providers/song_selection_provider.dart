import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/services/modals/song.dart';
import 'package:musify/services/modals/song_selection.dart';

class TurnOnOffSongSelectionNotifier extends StateNotifier<bool> {
  TurnOnOffSongSelectionNotifier() : super(false);

  void start() {
    state = true;
  }

  void stop() {
    state = false;
  }
}

final turnOnOffSongSelectionProvider =
    StateNotifierProvider<TurnOnOffSongSelectionNotifier, bool>(
      (ref) => TurnOnOffSongSelectionNotifier(),
    );

class SongSelectionNotifer extends StateNotifier<SongSelection> {
  SongSelectionNotifer() : super(SongSelection());

  void toggleSongSelection(Song song) {
    Map<String, Song> selectedSongs = state.selectedSongs;
    List<String> songsOrder = state.songsOrder;
    if (songsOrder.contains(song.id)) {
      songsOrder.remove(song.id);
      selectedSongs.remove(song.id);
    } else {
      songsOrder.add(song.id);
      selectedSongs[song.id] = song;
    }
    state = SongSelection(selectedSongs: selectedSongs, songsOrder: songsOrder);
  }

  void clear() {
    state = SongSelection();
  }
}

final songSelectionProvider =
    StateNotifierProvider<SongSelectionNotifer, SongSelection>(
      (ref) => SongSelectionNotifer(),
    );

final isSongSelectedProvider = Provider.family<bool, String>((ref, songId) {
  final selectedSong = ref.watch(songSelectionProvider);
  return selectedSong.songsOrder.contains(songId);
});

