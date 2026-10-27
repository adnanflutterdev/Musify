import 'package:musify/core/typedefs/typedefs.dart';
import 'package:musify/feature/song/data/models/song.dart';

abstract interface class SongsRepository {
  FResult<List<Song>> loadSongs(int limit);
  FResult<List<Song>> getSongsByIds(List<String> songIds);
}
