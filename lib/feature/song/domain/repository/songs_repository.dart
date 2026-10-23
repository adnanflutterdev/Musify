import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/song/data/models/new_song.dart';

abstract interface class SongsRepository {
  FResult<List<Song>> loadSongs(int limit);
}
