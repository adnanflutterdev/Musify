import 'package:musify/services/modals/song.dart';

class SongSelection {
  final Map<String, Song> selectedSongs;
  final List<String> songsOrder;

  SongSelection({Map<String, Song>? selectedSongs, List<String>? songsOrder})
    : selectedSongs = selectedSongs ?? {},
      songsOrder = songsOrder ?? [];
}
