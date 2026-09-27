import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/feature/song/models/song.dart';
import 'package:musify/feature/song/providers/songs_provider.dart';

final playlistProvider = Provider<List<Map>>((ref) {
  final myPlaylists = [];
  // final myPlaylists = ref.watch(userDataProvider).value?.myPlaylists ?? [];
  final songsMap = ref.watch(songsMapProvider);
  List<Map> playlist = [];
  for (Map map in myPlaylists) {
   final newMap = Map.of(map);
  newMap['songs'] = newMap['songs']
      .map((songId) => songsMap[songId])
      .whereType<Song>()
      .toList();
  playlist.add(newMap);
  }
  return playlist;
});
