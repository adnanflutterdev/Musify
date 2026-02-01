import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/main.dart';
import 'package:musify/feature/song/models/song_stream.dart';

final songStreamProvider = StreamProvider<SongStream>((ref) {
  return audioHandler.songStream;
});
