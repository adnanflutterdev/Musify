import 'dart:async';

import 'package:musify/core/result/result.dart';
import 'package:musify/feature/song/data/models/song.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/feature/song/domain/usecase/get_songs_by_ids_usecase.dart';
import 'package:musify/feature/song/domain/usecase/load_songs_usecase.dart';
import 'package:musify/feature/song/providers/di.dart';

class SongsNotifier extends AsyncNotifier<List<Song>> {
  late LoadSongsUsecase _loadSongsUsecase;

  @override
  FutureOr<List<Song>> build() async {
    _loadSongsUsecase = ref.read(loadSongsUsecaseProvider);

    return await _initializeSongs();
  }

  Future<List<Song>> _initializeSongs() async {
    Result<List<Song>> songsResult = await _loadSongsUsecase(
      SongLimitParam(50),
    );
    return songsResult.data ?? [];
  }

  Future<Result> loadMoreSongs([int? limit]) async {
    Result<List<Song>> songsResult = await _loadSongsUsecase(SongLimitParam());
    state = AsyncData([...(state.value ?? []), ...(songsResult.data ?? [])]);

    return songsResult;
  }
}

final songsProvider = AsyncNotifierProvider(() => SongsNotifier());

final songsByIdsProvider = FutureProvider.family<List<Song>, List<String>>((
  ref,
  param,
) async {
  final usecase = ref.read(getSongsByIdsUsecaseProvider);
  final result = await usecase(GetSongsByIdsUsecaseParams(param));

  return result.data ?? [];
});
