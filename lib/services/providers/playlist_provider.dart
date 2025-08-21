import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/services/modals/song.dart';
import 'package:musify/services/providers/songs_provider.dart';
import 'package:musify/services/providers/user_data_provider.dart';

final playlistProvider = Provider<List<Map>>((ref) {
  final myPlaylists = ref.watch(userDataProvider).value?.myPlaylists ?? [];
  final songsMap = ref.watch(songsMapProvider);
  List<Map> playlist = [];
  for (Map map in myPlaylists) {
    map['songs'] = map['songs']
        .map((songId) => songsMap[songId])
        .whereType<Song>()
        .toList();
    playlist.add(map);
  }
  return playlist;
});
